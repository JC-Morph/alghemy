require 'alghemy/options'

module Alghemy
  module Modules
    # Public: Methods used to dissect a path. Similar to Pathname, but more
    # String oriented.
    module Trail
      # Public: Slice shortcut for Trail parts.
      #
      # Returns String.
      def []( idx )
        return slice(idx) if n.class == Regexp
        num_index[idx.to_s]
      end

      # Public: Convert Trail for Windows processes.
      #
      # Returns String.
      def fenestrate
        seps = %w[/ \\]
        path = swap_parts dir: dir.gsub(*seps)
        "\"#{path.sub(*seps)}\""
      end

      # Public: Replace parts in Trail.
      #
      # lyst - Hash of parts to replace.
      #        :dir  - Directory.
      #        :base - Basename.
      #        :ext  - Extension.
      #
      # Returns new instance of class.
      def swap_parts( lyst = {} )
        swap = parts.merge lyst
        file = swap[:base] + swap[:ext]
        self.class.new File.join(swap[:dir], file)
      end

      # Public: Attempt to return unique part of Trail.
      def label
        unique || base
      end

      # Public: Returns Directory.
      def dir
        File.dirname self
      end

      # Public: Attempt to detect unique directory if present.
      def unique
        # TODO: figure out how to get actual unique label
        unique = dir[/(?<=#{SEP})[^#{SEP}]+/]
        unique || dir[/[^#{SEP}\.]+$/]
      end

      # Public: Basename.
      def base
        File.basename(self, '.*')
      end

      # Public: Extension.
      def ext
        File.extname(self).to_s
      end

      private

      # Internal: Returns Hash containing a numerical index for #slice shortcut
      # (#[]).
      def num_index
        {'-2' => dir, '-1' => unique, '0' => base, '1' => ext}
      end

      # Internal: Returns Hash containing default parts of sijil used by
      # #swap_parts.
      def parts
        {dir: dir, base: base, ext: ext}
      end
    end
  end
end
