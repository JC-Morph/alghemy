# Public: Extension module. Allows the definition of aspect methods on class.
# Each aspect is defined on class by name, and calls duck asps with said name.
# Expects duck for methods: aspects, asps.
module Clasps
  # Internal: Add aspect names as methods.
  def def_asps
    return if aspects.all? {|asp| method_defined? asp }
    aspects.each do |aspect|
      define_method aspect do
        asps aspect
      end
    end
  end

  def aspects
    []
  end
end
