module Filename
  # Slice shortcut for Filename parts
  # @return [String]
  def []( n )
    return slice(n) if n.class == Regexp
    num_index[n.to_s]
  end

  # Convert path for Windows processes
  # @return [String]
  def fenestrate
    seps = %w[/ \\]
    path = swap_parts dir: dir.gsub(*seps)
    "\"#{path.sub(*seps)}\""
  end

  # Replace parts in Filename
  #
  # @param lyst [Hash] parts to replace
  # @option lyst [String] dir
  # @option lyst [String] base
  # @option lyst [String] ext
  def swap_parts( lyst = {} )
    swap = parts.merge lyst
    file = swap[:base] + swap[:ext]
    self.class.new File.join(swap[:dir], file)
  end

  # Attempt to return unique part of Filename
  def label
    unique || base
  end

  # Directory
  def dir
    File.dirname self
  end

  # Attempt to detect unique directory if present
  def unique
    # TODO: figure out how to get actual unique label
    unique = dir[/(?<=#{SEP})[^#{SEP}]+/]
    unique || dir[/[^#{SEP}\.]+$/]
  end

  # Basename
  def base
    File.basename(self, '.*')
  end

  # Extension
  def ext
    File.extname(self).to_s
  end

  private

  def num_index
    {'-2' => dir, '-1' => unique, '0' => base, '1' => ext}
  end

  def parts
    {dir: dir, base: base, ext: ext}
  end
end
