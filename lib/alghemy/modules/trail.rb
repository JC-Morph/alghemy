require 'alghemy/comrades'
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

      # Public: Open Matter with default application.
      def behold
        spell = Gem.win_platform? ? fenestrate : "xdg-open #{to_s}"
        Comrades[:invoker].cast "#{spell} 2>&1"
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
      # other_parts - Hash of parts to replace.
      #              :dir  - Directory.
      #              :base - Basename.
      #              :seq  - Numerical sequence.
      #              :ext  - Extension.
      #
      # Returns new instance of class.
      def swap_parts( other_parts = {} )
        swap = parts.merge other_parts
        file = swap[:base]
        file += swap[:seq] if swap[:seq]
        file += swap[:ext]
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
        self.class.new gsub(/[_-]*(?<!\\)[\*\?]+/, '')
      end

      #TODO: broke
      def ffglob
        glob = "_%0#{first.base_num.size}d"
        swap_parts base: unglob.base.concat(glob)
      end

      def base_num
        base[/(?<=[_-])*\d+(?=\.)*$/]
      end

      private

      # Internal: Returns Hash containing a numerical index for #slice method.
      def num_index
        {'-2' => dir, '-1' => label, '0' => base, '1' => ext}
      end

      # Internal: Returns Hash containing default parts of a filename used by
      # #swap_parts method.
      def parts
        {dir: dir, base: base, ext: ext}
      end
    end
  end
end
