require 'yaml'
require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain executable scripts that are utilised by
  # auxiliary utilities.
  module Scripts
    extend Bandoleer

    vials = %w[mv_average.js mv_sink.js plot_ample plot_spectral]

    vials.each do |vial|
      pockets.register(vial) do
        dir  = name.split('::').last.downcase
        File.join(__dir__, dir, vial)
      end
    end
  end
end
