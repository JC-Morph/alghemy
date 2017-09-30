# Test test_sijil for identifiable affinity.
module Affinitester
  def affinity
    discern || Element
  end

  def discern
    [Sound, Video, Image].each do |affinity|
      return affinity unless wrong affinity
    end
    nil
  end

  def test_sijil
    raise NotImplementedError
  end

  private

  def wrong( affinity )
    report = affinity.tools.analyse.this test_sijil
    affinity.tests.any? do |test|
      test.class == Regexp ? report =~ test : !report[/#{test}/]
    end
  end
end
