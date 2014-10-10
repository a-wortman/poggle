Poggle is a parser generator built to produce parsers for data formats in any supported target language. ~Poggle's parsers can be used on any sequenced collection of bytes as defined by the target language, and produces structures in the target language for consumption if parsing succeeds.~ (Poggle does not yet produce structures in the target language, or even allow targetting a language.)

Poggle generates parsers using rules specified in rule files. The grammar describing poggle rules is given in [poggle.rtlr](poggle.rtlr), a grammar for [Rattler](https://github.com/jarhart/rattler).

Poggle rule files have ~two~ (at least two, possibly more) sections: function declarations and rule components.

Rules in a Poggle grammar begin immediately after the line
```
:components:
```
and are explained below. Multiple newlines between rules is totally acceptable!

*The Basics: Poggle rules*
A parser's rules are declared to Poggle by statements in the form
```
<name>[: size][ := <body>]
```
where the size and body declarations are individually optional, but at least one must be present. Size refers the amount of data the rule matches to, in bits, bytes, or some other unit.

In the case of
```
<name>: <size> := <body>
```
Poggle looks to ensure that the rule's body matches exactly the amount of space declared by <size>.

Example: `File: byte{4} := Header:Body` is read as a rule named `File`, expected to match exactly four bytes, given the structure described by `Header:Body`. (More on that later)

For rules like
```
<name>: <size>
```
Poggle matches to exactly <size> data. This becomes really useful later!

Example: `Data: byte{8}` is a rule named `Data` that matches any eight bytes in place of the name `Data` anywhere else in the grammar.

Lastly, rules like
```
<name> := <body>
```
are useful for ascribing nice names to structures.

Example: `Record := Email:Name:Address`.

*Literals*
Grammatical rules, especially Poggle's rules, are only useful if they can actually match against something. For Poggle, that something is bytes, bits, or some other primitive in a data stream. Poggle supports this very directly:

Examples:
```
<name> := <literal>

One := 0x01
ByteOne := b00000001
BitOne := b1
IntOne := 1
StringOne := "1"
UnicodeString := u"<fill in with emoji>"
CStringOne := "1"
```

Sizes are inferred to be the smallest size that matches the literal typed... Most of the time. `b00000001` is presumed to be 8 bits == 1 byte, `b1` is one bit.

The integer `1` on the other hand is the size of an `int` in the target language, defaulting to 32 bits. **come back to this... might want to rethink it.**

Strings take exactly the number of bytes they match against under the given encoding, falling back to UTF-8 if nothing is explicitly stated.

Strings are ***not*** null terminated. For C-string style, see [below](conjunction).

*Conjunctions*
The easiest way to get started matching against files is to be able to say "B follows A". Poggle expresses that relation as `:` between two matching bodies.

Example:
```
File := 0x04:Body
```
or
```
MagicNumber := 0xCA:0xFE:0xBA:0xBE
Data: byte{16}
File := MagicNumber:Data
```

The second example above matches any file starting with the bytes `CA FE BA BE` and any sixteen bytes following. If you can make 20-byte class files, this could be used for them! ;)

*Disjunction*
Sometimes data has a structure that requires saying "B follows A.. or otherwise C follows A". This is stated in Poggle by using `|` between two matching bodies.

Example:
```
File := 0x01|0x02:0x03
```

The above matches either `0x01` or `0x02:0x03`. `|` is lower precedence than `:`!

*Parenthetization*
Parentheses are purely for overriding precedence. Or style, if you want more LISP-y grammars.

Example:
```
File := (0x01:0x02)|0x03

vs

File := 0x01:(0x02|0x03)
```

*Match binding*
Any time an expression is declared in a rule, it can be bound to a variable by prepending `name\` to the expression. This isn't immediately useful on its own, but is extremely useful for the next two features!

Example:
```
value: byte
File := v\value
```

*Repetition*
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

*Function declarations*
Poggle allows rule files to rely on computations in the target language, but requires those functions be declared so it can give an error if the function is unavailable.
These aren't implemented yet, but should be callable by `<symbol>(values, to, pass, in)` and binding the result.

Example:
```
:functions:
foo(byte{4}, element): byte{_}
bar(byte{4}): byte{2}

:components:
element: byte
x := a\byte{4}:e\bar(a):foo(a, e){2}
```

