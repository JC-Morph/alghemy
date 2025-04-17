require 'yaml'
require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain yaml files denoting useful information.
  module Data
    extend Bandoleer

    vials = %w[ffmpeg_encoders ffmpeg_pixel_formats ladspa]

    vials.each do |vial|
      pockets.register(vial) do
        dir  = name.split('::').last.downcase
        file = File.join(__dir__, dir, "#{vial}.yml")
        YAML.load_file file
      end
    end
  end
end
