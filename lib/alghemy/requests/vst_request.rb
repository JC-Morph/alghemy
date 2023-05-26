require 'alghemy/comrades'
require 'alghemy/methods'

module Alghemy
  module Requests
    module VstRequest
      class << self
        include Methods[:alget]

        def read_info( plugin )
          plugin  = "-p #{plugin.to_s}"
          process = [moniker(plugin), plugin, '--display-info']
          parse_info(write_data(process))
        end

        def read_list
          process = [moniker, '--list-plugins']
          parse_list(write_data(process))
        end

        private

        def write_data( process )
          execute(process << redirect)
          File.read tmp_name
        end

        def execute( process )
          FileUtils.makedirs File.dirname(tmp_name)
          Comrades[:invoker].io process
        end

        def moniker( plugin = '' )
          "mrswatson#{plugin[/64/]}.exe"
        end

        def redirect
          "2> #{tmp_name}"
        end

        def tmp_name
          File.join(alget(:ROOT), '.vst_info')
        end

        def parse_info( info )
          info.split(/\r*\n/)
        end

        def parse_list( list )
          list.split.map do |line|
            line[/(?<=\\)[+\w][\w.-]+.$/] if line[/Vst/]
          end.compact
        end
      end
    end
  end
end
