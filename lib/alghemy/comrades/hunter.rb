require 'fuzzy_match'
require 'alghemy/factories'
require 'alghemy/glyphs'

module Alghemy
  module Comrades
    module Hunter
      class << self
        attr_reader :scent, :fuzzgun

        def find( sijil )
          @scent = sijil
          klass  = sijil.class.name.downcase
          list   = send "find_#{klass}"
          Factories[:scribe].call list
        end
        alias_method :[], :find

        def find_string
          @fuzzgun = FuzzyMatch.new(Dir.glob('**/*.*'))
          fuzzgun.find_all(scent)[0..19]
        end

        def find_symbol
          Glyphs[:archive].select do |sijil, entry|
            entry.values.include? scent
          end.keys
        end

        def find_regexp
          Dir.glob('**/*.*').select do |file|
            file[scent]
          end.reverse
        end
      end
    end
  end
end
