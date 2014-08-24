require 'rattler'
require_relative './poggler'

class PogglerParser < Rattler::Runtime::PackratParser

  include Poggler

end
