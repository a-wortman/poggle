Poggle is a parser generator built to produce parsers for data formats in any supported target language. ~~Poggle's parsers can be used on any sequenced collection of bytes as defined by the target language, and produces structures in the target language for consumption if parsing succeeds.~~ Poggle does not yet produce structures in the target language, or even allow targetting a language.

Requires ruby 2.1.2 (for Fixnum#bit_length)

To get started, currently you'll want to do the following:
  0. Clone the repo (`git clone git@github.com:a-wortman/poggle.git`)
  0. `gem install rattler`
  0. `./gen_poggle.sh`
  0. TODO: update this, should be one less step

Poggle generates parsers using rules specified in rule files, with examples for [deflate](formats/deflate_data), [gzip](formats/gzip), and [JVM class files](formats/class_file). The grammar describing poggle rules is given in [poggle.rtlr](poggle.rtlr), a grammar for [Rattler](https://github.com/jarhart/rattler).

Poggle rule files have ~~two~~ (at least two, possibly more) sections: function declarations and rule components.

Rules in a Poggle grammar's rules begin immediately after the line
```
:components:
```
and are explained below:

## The Basics: Poggle rules
A parser's rules are declared to Poggle by statements in the form
```
<name>[: size][ := <body>]
```
where the size and body declarations are individually optional, but at least one must be present. Size refers the amount of data the rule matches to, in bits, bytes, or some other unit.

In the case of
```
<name>: <size> := <body>
```
Poggle looks to ensure that the rule's body matches exactly the amount of space declared by `size`.

Example: `File: byte{4} := Header:Body` is read as a rule named `File`, expected to match exactly four bytes, given the structure described by `Header:Body`. (More on that later)

For rules like
```
<name>: <size>
```
Poggle matches to exactly `size` data. This becomes really useful later, when you need to get `size` bytes with unknown values.

Example: `Data: byte{8}` is a rule named `Data` that matches any eight bytes wherever `Data` is used in the grammar.

Lastly, rules like
```
<name> := <body>
```
are useful for ascribing nice names to structures. Poggle is whitespace insensitive, so for example
```
emailChar := byte &! '@'

chars := emailChar{_}

Email := prefix:'@':postfix
Record := Email:Name:Address
```
is a perfectly fine set of rules.

## Size annotations
Sizes (just like how they're used above) are notated as either `bit` or `byte`, and optionally followed by `{<expression>}`

These declare the size of the rule they annotate: for any `<unit>{<expression>}`, that rule matches exactly `<expression>` many `<unit>`s

## Literals
Grammatical rules, especially Poggle's rules, are only useful if they can actually match against something. For Poggle, that something is bytes, bits, or some other primitive in a data stream. Poggle supports this very directly:

Sizes are somewhat intelligently inferred: sizes are taken to be the smallest unit size that can contain the literal.

| Expression | Type           | Unit size (bits) |
| ---------- | -------------- | ---------------- |
| 0x1        | Hex value      | 8                |
| b1         | Bit string     | 1                |
| 1          | Integer        | 8                |
| '1'        | Character      | 8                |
| "1"        | (UTF-8) String | 8                |
| u"1"       | UTF-8 String   | 8\*              |
| u16"1"     | UTF-16 String  | 16\*             |
| u32"1"     | UTF-32 String  | 32               |

Examples:
```
<name> := <literal>

One: byte := 0x01
ByteOne: bit{8} := b00000001
BitOne: bit{1} := b1
IntOne: byte := 1
CharOne: byte := '1'
StringOne: byte := "1"
UnicodeString: byte{3} := u"💽"
```

Strings are ***not*** null terminated. For C-string style, use conjunction (see below) to require `0x00` after your string.

\* actual sizes may well not be `characterCount * unitSize`, Unicode may or may not use multiple code points for a single symbol

## Conjunction
The easiest way to get started matching against files is to be able to say "A is followed by B". Poggle expresses that relation as `:` between two expressions.

Example:
```
MagicNumber := 0xCA:0xFE:0xBA:0xBE
Data: byte{16}
File := MagicNumber:Data
```

The second example above matches any file starting with the bytes `CA FE BA BE` and any sixteen bytes following.

Also useful is combining a string from above with `:`

## Disjunction
Sometimes data has a structure that requires saying "X is A or B". This is stated in Poggle by using `|` between two expressions.

Example:
```
File := 0x01|0x02:0x03
```

The above matches either `0x01` or `0x02:0x03`. `|` is lower precedence than `:`!

## Parenthetization
Parentheses are purely for overriding precedence. Or style, if you want more LISP-y grammars.

Example:
```
File := (0x01:0x02)|0x03

vs

File := 0x01:(0x02|0x03)
```

## Match binding
Any time an expression is declared in a rule, it can be bound to a variable by prepending `name\` to the expression. This isn't immediately useful on its own, but is extremely useful for the next two features!

Example:
```
value: byte
File := v\value
```

## Repetition
Rules can be repeated a specified number of times, where that number can be a literal, a math expression, or the name to which an expression's match result is bound~, if that result can be converted to a number~.

Example:
```
content: byte
size: byte{2}
File := content{2}
File2 := content{2 * 8}
File3 := s\size:content{s}
File4 := s\size:content{s * 2}
```

## Function declarations
Poggle allows rule files to rely on computations in the target language, but requires those functions be declared so it can give an error if the function is unavailable.
These aren't implemented yet, but should be callable by `<symbol>(values, to, pass, in)`, with the ability to match or bind the result like any expression.

Example:
```
:functions:
foo(byte{4}, element): byte{_}
bar(byte{4}): byte{2}

:components:
element: byte
x := a\byte{4}:e\bar(a):foo(a, e){2}
```
