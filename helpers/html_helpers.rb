module ShowTracker
  module HTMLHelpers
    def link_to(url, text = url, options = {})
      tag :a, text, options.merge(href: url)
    end

    def link_button(url, text = url, type = '', size = '', options = {})
      btn_class = "btn"
      btn_class << " btn-#{type.to_s}" unless type.empty?
      btn_class << " btn-#{size.to_s}" unless size.empty?

      if options[:class].nil?
        p 'nil!'
        options[:class] = btn_class
      else
        options[:class] = btn_class << " " << options[:class]
      end

      p options
      link_to url, text, options
    end

    def glyphicon(name)
      tag 'span', '', class: "glyphicon glyphicon-#{name.to_s}"
    end

    def hash_to_html_attributes(options = {})
      html_attributes = ""
      options.each do |key, value|
        next if value.nil?
        html_attributes << %Q(#{key}="#{value}" )
      end
      html_attributes.chop
    end

    def single_tag(name, options = {})
      "<#{name.to_s} #{hash_to_html_attributes(options)} />"
    end

    def tag(name, content, options = {})
      output = "<#{name.to_s}"

      unless options.length.zero?
        output << ' ' << hash_to_html_attributes(options)
      end

      output + (content.nil? ? '>' : ">#{content}</#{name}>")
    end
  end
end
