module MiscHelpers
  def relative_link_to(text, target, attributes = {})
    link_to(text, relative_path_to(target), attributes)
  end

  def toc
    "- TOC\n{:toc}"
  end
end

include MiscHelpers
