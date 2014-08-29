class AnyBytes
  def initialize(size)
    if size
      @size = size
    else
      @size = ConstSize.new 1
    end
    puts "Expecing #{@size.value} bytes"
  end

  def duplicate
    AnyBytes.new @size
  end

  def match(bytes)
    @data = []
    for i in 0..@size.value-1
      if bytes.eof
        return false
      else
        @data.unshift bytes.next
      end
      puts "Matched bytes #{@data}"
    end
    true
  end

  def matched
    @data
  end

  def clone
    puts "Cloning!"
    AnyBytes.new ConstSize.new @size
  end

  def resolved
    true
  end
end
