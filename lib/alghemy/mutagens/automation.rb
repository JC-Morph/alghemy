# NOTE: REFERENCE FILE NOT USED PLEASE MIGRATE
#       SHOULD BE INCORPORATED INTO AUTOMATO
# Public: Provides methods to create automation templates for vst parameters.
module Automation
  class << self
    attr_reader :n_params, :stuff

    def generate( stuff = {} )
      @stuff = defaults.merge stuff
      init_params stuff[:params] || rand_params
    end

    def rand_params
      params   = (0..stuff[:total] - 1).to_a
      n_params = stuff[:n_params] || rand(bounds)
      n_params.times.with_object([]) do |_, arr|
        arr << params.shuffle!.pop
      end
    end

    def init_params( params )
      params.sort.collect do |param|
        operator = rand_operator
        if param[1].is_a? Hash
          param = param[0]
          operator.merge! param[1]
        end
        [param, operator]
      end
    end

    def rand_operator
      operator = {operator: %i[+ -].sample}
      column = stuff[:column]
      column = (0..column - 1).to_a if column.is_a? Integer
      operator.merge(index: column.sample)
    end

    private

    def defaults
      {min: '25%', max: '75%', column: 1}
    end

    # Internal: Returns the Range in percentages of possible parameters to be
    # automated.
    def bounds
      bounds    = [stuff[:min], stuff[:max]].map(&:to_f)
      bounds[1] = bounds.max
      min, max = bounds.map do |percent|
        (stuff[:total].fdiv(100) * percent).round
      end
      min..max
    end
  end
end
