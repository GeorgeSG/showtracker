module ApplicationHelper
  def glyphicon(name)
      content_tag :span, '', class: "glyphicon glyphicon-#{name.to_s}"
    end
end
