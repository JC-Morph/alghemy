require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Perform an inverse fourier transform with image magick.
    class Ift < Ancestors[:transmutation]
      def rubric
        Rubrics[:fourier]
      end

      def tran_init
        stuff[:enum] = :group
        @tome = sub_tome if stuff[:magni] || stuff[:phase]
        @mult = false if @tome.size == 2
      end

      private

      # Public: Define Tome (list of inputs) to be used. Parses inputs, which
      # may include explicit :magnitude or :phase images.
      def sub_tome
        tome = %i[magni phase].collect do |part|
          part = stuff[part] || stuff[:tome]
          part.is_a?(Array) ? part : part.list
        end.transpose
        tome.flatten! if tome.size == 1
        list tome
      end
    end
  end
end
