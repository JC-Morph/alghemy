require 'fuzzy_match'
require 'alghemy/factories'
require 'alghemy/glyphs'

module Alghemy
  module Comrades
    # Public: Fuzzy finder for potential Matter.
    module Hunter
      class << self
        attr_reader :scent, :fuzzgun

        def fetch( sijil )
          tome = find(sijil)
          tome.index
          puts 'select index'
          tome[gets.chomp.to_i].evoke
        end

        def find( sijil )
          @scent = sijil
          klass  = sijil.class.name.downcase
          list   = send "find_#{klass}"
          Factories[:scribe].call list
        end
        alias [] find

        def find_string
          @fuzzgun = FuzzyMatch.new(Dir.glob('**/*.*'))
          fuzzgun.find_all(scent)[0..19]
        end

        def find_symbol
          Glyphs[:archive].select do |_sijil, entry|
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
