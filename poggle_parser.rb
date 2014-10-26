require 'rattler'
require_relative './poggler_parser'

class PoggleParser < Rattler::Runtime::PackratParser

  include PogglerParser

end
