module Automation
  class << self
    attr_reader :n_params, :cata

    def generate( lyst = {} )
      @cata = defaults.merge lyst
      init_params cata[:params] || rand_params
    end

    def rand_params
      params   = (0..cata[:total] - 1).to_a
      n_params = cata[:n_params] || rand(bounds)
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
      axi = cata[:axi]
      axi = (0..axi - 1).to_a if axi.is_a? Integer
      op.merge(index: axi.sample)
    end

    private

    def defaults
      {min: '25%', max: '75%', axi: 1}
    end

    def bounds
      bounds   = [cata[:min], cata[:max]]
      min, max = bounds.collect do |percent|
        (cata[:total].fdiv(100) * percent.to_f).round
      end
      min..max
    end
  end
end
