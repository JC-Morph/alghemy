require 'yaml'
require 'alghemy/bandoleer'

module Alghemy
  module Data
    extend Bandoleer

    vials = %w[lads]

    vials.each do |vial|
      bandoleer.register(vial) do
        dir  = name.split('::').last.downcase
        file = File.join(__dir__, dir, vial + '.yml')
        YAML.load(File.read(file))
      end
    end
  end
end
