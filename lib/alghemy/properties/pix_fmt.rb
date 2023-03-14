module Alghemy
  module Properties
    # Public: Represents valid ffmpeg compatible pixel formats.
    class PixFmt
      attr_reader :sijil

      class << self
        def list( which = :any )
          list = index[8..-1]
          test = keep[which]
          list.map {|line| line.split[1] if line[test] }
            .compact
        end

        def any
          new(random(__callee__))
        end
        alias input any
        alias output any

        def index
          `ffmpeg -loglevel warning -pix_fmts`.split("\n")
        end

        def keep
          {
            input: /^I(\.|O)/,
            output: /^(\.|I)O/,
            any: /^(I(\.|O)|(I|\.)O)/
          }
        end

        def random( which = :any )
          list(which).sample
        end
      end

      def initialize( sijil = self.class.random )
        @sijil = sijil
      end
    end
  end
end
