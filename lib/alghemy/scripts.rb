require 'yaml'
require 'alghemy/bandoleer'

module Alghemy
  module Scripts
    extend Bandoleer

    vials = %w[mv_average mv_sink]

    vials.each do |vial|
      bandoleer.register(vial) do
        dir  = name.split('::').last.downcase
        File.join(__dir__, dir, vial + '.js')
      end
    end
  end
end
