# 2-dimensional aspect for visual Elements, i.e. height x width
class Space < String
  extend Forwardable
  delegate :reduce => :dims

  # Constructor method; parses space according to class.
  # Optionally uses subspace to substitute missing dims.
  def self.trace( space, subspace = nil )
    space = case space
            when String || self.class
              space
            when Array
              draw(space, subspace).join('x')
            when Integer
              "#{space}x#{subspace[1]}"
            end
    new space || subspace
  end

  # Build valid space from Array
  def self.draw( arr, subspace )
    return arr if subspace.nil?
    space = arr.collect.with_index do |dim, i|
      dim.zero? ? subspace[i] : dim
    end
    space << subspace[1] if space.size == 1
    space
  end

  # Slice shortcut for dimensions
  def []( n )
    dims.slice({x: 0, y: 1}[n] || n)
  end

  # Return Array of dimensions.
  def dims
    split('x').collect(&:to_i)
  end

  # Comparison method; compare by number of pixels.
  def >( other )
    raise ArgumentError unless other.respond_to? :reduce
    reduce(:*) > other.reduce(:*)
  end
end
