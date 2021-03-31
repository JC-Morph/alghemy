require 'alghemy/methods'

module Alghemy
  module Modules
    # Public: Methods used to dissect a path. Similar to Pathname.
    module Trail
      include Methods[:alget]

      # Public: Slice shortcut for Trail parts.
      def []( idx )
        return num_index[idx.to_s] if (-2..1).include?(idx.to_i)
        slice idx
      end

      def slice
        raise NotImplementedError
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

      # Public: Returns Directory.
      def dir
        File.dirname self.to_s
      end

      # Public: Attempt to detect a descriptive directory if present.
      def dir_label
        root = alget(:ROOT)
        sep  = alget(:SEP)
        child_dir  = dir[/(?<=#{root + sep})[^#{sep}]+/]
        child_dir || dir[/[^#{sep}\.]+$/]
      end

      # Public: Basename.
      def base
        File.basename(self.to_s, '.*')
      end

      # Public: Extension.
      def ext
        File.extname self.to_s
      end

      # Public: Attempt to return unique part of Trail.
      def label
        dir_label || unglob.base
      end

      def unglob
         raise NotImplementedError
      end

      def ffglob
        glob = "_%0#{first.base_num.size}d"
        swap_parts base: unglob.base.concat(glob)
      end

      def base_num
        base[/(?<=[_-])\d+$/]
      end

      private

      # Internal: Returns Hash containing a numerical index for #slice method.
      def num_index
        {'-2' => dir, '-1' => label, '0' => base, '1' => ext}
      end

      # Internal: Returns Hash containing default parts of sijil used by
      # #swap_parts method.
      def parts
        {dir: dir, base: base, ext: ext}
      end
    end
  end
end
