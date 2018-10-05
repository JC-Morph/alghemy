require 'alghemy/options'

module Alghemy
  module Methods
    # Internal: Requires necessary files, intended for use in containers.
    module Retrieve
      def retrieve( files )
        [files].flatten.each do |file|
          file = file.to_s
          next if const_defined? file.split('_').map(&:capitalize).join
          require File.join(name.sub('::', SEP).downcase, file)
        end
      end
    end
  end
end
