module ApplicationHelper
  def glyphicon(name)
    content_tag :span, '', class: "glyphicon glyphicon-#{name.to_s}"
  end

  def random_fanart
    return nil if Show.count.zero?
    Show.where.not(fanart: "").all.sample.fanart
  end
end
