class AnyBytes
  def initialize(size)
    @data = []
    if size
      @size = size.value
    else
      @size = 1
    end
    puts "Expecing #{@size} bytes"
  end

  def duplicate
    AnyBytes.new ConstSize.new @size
  end

  def match(bytes)
    puts @size
    for i in 0..@size-1
      if bytes.eof
        return false
      else
        @data.unshift bytes.next
      end
      puts "Matched bytes #{@data}"
    end
    true
  end

  def clone
    puts "Cloning!"
    AnyBytes.new ConstSize.new @size
  end

  def resolved
    true
  end
end
