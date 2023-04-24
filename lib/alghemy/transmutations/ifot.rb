require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Perform an inverse fourier transform with image magick.
    class Ifot < Ancestors[:transmutation]
      def rubric
        Rubrics[:fourier]
      end

      def tran_init
        stuff[:enum] = :group
        @tome = sub_tome if stuff[:magni] || stuff[:phase]
        @mult = false if tome.size == 2
      end

      private

      # Internal: Define Tome (list of inputs) to be used.
      # Parses inputs, which may include explicit :magnitude or :phase images.
      def sub_tome
        tome = collect_components
        tome.flatten! if tome.size == 1
        list tome
      end

      def collect_components
        %i[magni phase].map do |cmpnt|
          cmpnt = stuff[cmpnt] || stuff[:tome]
          cmpnt.is_a?(Array) ? cmpnt : cmpnt.list
        end.transpose
      end
    end
  end
end
