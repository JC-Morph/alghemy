require 'yaml'
require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain yaml files denoting useful information.
  module Data
    extend Bandoleer

    vials = %w[ladspa]

    vials.each do |vial|
      bandoleer.register(vial) do
        dir  = name.split('::').last.downcase
        file = File.join(__dir__, dir, "#{vial}.yml")
        YAML.load_file file
      end
    end
  end
end
