require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define an executable process for a command passed to MrsWatson.
    class Mrs < Ancestors[:rubric]
      def self.moniker
        ['mrswatson']
      end

      def self.switch_plates
        [[:p, :plugin, 'mrs_passthru']]
      end

      # Public: Method for processing sound with Vsts using MrsWatson utility.
      def mutate
        vst = cata[:vst]
        input.plugin(vst.sijil)
        automate if cata[:data]
        output
      end

      # Public: Method for keeping track of automation iterations.
      def automate
        @count ||= 0
        vst.automatons.each {|am| param(am) }
        @count += 1
      end

      def parameter( *automaton )
        param, auto = automaton.flatten
        param = [param, operate(auto)]
        add ['--parameter', param * ',']
      end
      alias param parameter

      # Public: Method for adding input and output to process.
      def input
        io = __callee__
        add ["-#{io[/^\w/]}", "%<#{io}>s"]
      end
      alias output input

      private

      # Private: Return automation data at the current count.
      def data
        cata[:data][@count]
      end

      def operate( auto )
        return auto unless auto.is_a?(Hash)
        op    = auto[:operator]
        bndry = {'+' => 0.0, '-' => 1.0}[op.to_s]
        auto  = [bndry, data[auto[:index]]]
        auto.reduce op
      end
    end
  end
end
