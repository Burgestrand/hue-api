module CustomHelpers
  def relative_link_to(text, target, attributes = {})
    link_to(text, relative_path_to(target), attributes)
  end
end
