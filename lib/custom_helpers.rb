module CustomHelpers
  def relative_link_to(text, target, attributes = {})
    link_to(text, relative_path_to(target), attributes)
  end

  %w[get post put delete].each do |method|
    define_method("#{method}_to") do |url, docpage, attributes = {}|
      relative_link_to("#{method.upcase} to #{url}", docpage, attributes)
    end
  end
end
