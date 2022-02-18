class String
  def in?(*arr)
    !([self] & arr).empty?
  end
end
