require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain factory modules, used to create instances
  # of a known superclass but unknown subclass. Expected to have a separate
  # creation method. These are easiest to represent with lambdas, which then
  # make factories respond to #call.
  module Factories
    extend Bandoleer

    evoke = lambda do |clss, sijil, lyst = {}|
      affinity = clss.name.split('::').last.downcase
      Evoker.send(affinity, sijil, lyst)
    end
    transcribe = lambda do |list, dims = nil|
      Scribe.transcribe(list, dims)
    end

    equip evoker: evoke, scribe: transcribe
  end
end
