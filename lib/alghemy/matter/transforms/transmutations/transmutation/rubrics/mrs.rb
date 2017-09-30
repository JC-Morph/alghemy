require_relative 'rubric'

# Define an executable string and related variables for
#  a command passed to the mrswatson vst utility
class Mrs < Rubric
  attr_reader :count

  def mutate
    vst = cata[:vst]
    process = ['-i', input, '-p', vst.sijil]
    if cata[:data]
      @count ||= 0
      vst.automatons.each do |automaton|
        process << param(automaton)
      end
      @count += 1
    end
    process << ['-o', output]
  end

  private

  def moniker
    ['mrswatson']
  end

  def data
    cata[:data][count]
  end

  def param( automaton )
    index, auto = automaton
    param = [index, operate(auto)]
    ['--parameter', param * ',']
  end

  def operate( auto )
    op    = auto[:operator]
    bndry = {'+' => 0.0, '-' => 1.0}[op.to_s]
    auto  = [bndry, data[auto[:index]]]
    auto.reduce op
  end
end
