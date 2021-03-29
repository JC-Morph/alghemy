require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Display image files with xnview.
    module ImageView
      class << self
        include Modules[:request]

        def moniker
          ['xnview']
        end

        def sub_process
          input << redirect
        end

        def redirect
          '1>&2'
        end

        def windows_process?
          true
        end
      end
    end
  end
end
