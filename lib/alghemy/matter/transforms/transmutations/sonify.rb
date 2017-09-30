require_relative 'transmutation'
require_relative 'mutypes/foot'

# Transmute visual Matter into Sound
class Sonify < Transmutation
  include Foot

  def tran_init
    cata[:ents].balance( 'flo', :push )
    cata[:ext] ||= '.wav'
  end
end
