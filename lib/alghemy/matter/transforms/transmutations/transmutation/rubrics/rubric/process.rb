module Process
  class << self
    def run( process, io = {} )
      process = flatten(process) % io
      execute process
    end

    def flatten( process )
      return process if process.is_a? String
      process.flatten.join(' ')
    end

    def execute( process )
      `#{process}`
    end
  end
end
