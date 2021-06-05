require 'alghemy/apparatus'
require 'alghemy/data'

module LadspaInfo
  LADS = Data[:LADS]

  def name
    LADS[sijil][__callee__]
  end
  %i[label id audio].each do |attr|
    alias_method attr, :name
  end

  def controls
    LADS[sijil][__callee__] || {}
  end
  alias_method :post_fx, :controls

  def sijil
    raise NotImplementedError
  end
end
