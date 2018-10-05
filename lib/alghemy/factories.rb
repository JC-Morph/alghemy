require 'alghemy/modules'

module Alghemy
  # Public: Bandoleer. Vials contain factory modules, used to create instances
  # of a known superclass but unknown subclass. Expected to have one creation
  # method, instigated with a lambda, and so responding to the #call method.
  module Factories
    extend Modules[:bandoleer]

    evoke = lambda do |clss, sijil, lyst = {}|
      type = clss.name.split('::').last.downcase
      Evoker.send(type, sijil, lyst)
    end
    transcribe = lambda do |list, dims = nil|
      Scribe.transcribe(list, dims)
    end

    equip evoker: evoke, scribe: transcribe
  end
end
