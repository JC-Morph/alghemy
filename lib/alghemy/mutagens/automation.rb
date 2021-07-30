# Public: Provides methods to initialise automation templates for adjustable
# parameters.
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
        operator = rand_op
        if param[1].is_a? Hash
          param = param[0]
          operator.merge! param[1]
        end
        [param, operator]
      end
    end

    def rand_op
      op  = {operator: %i[+ -].sample}
      axi = stuff[:axi]
      axi = (0..axi - 1).to_a if axi.is_a? Integer
      op.merge(index: axi.sample)
    end

    private

    def defaults
      {min: '25%', max: '75%', axi: 1}
    end

    def bounds
      bounds   = [stuff[:min], stuff[:max]]
      min, max = bounds.collect do |percent|
        (stuff[:total].fdiv(100) * percent.to_f).round
      end
      min..max
    end
  end
end
