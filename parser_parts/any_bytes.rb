class AnyBytes
  def initialize(size)
    if size
      @size = size.evaluate
    else
      @size = 1
    end
    puts "Expecing #{@size} bytes"
  end
end
