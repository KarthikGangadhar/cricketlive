module SeoPageContent

  # To be accessed through respective controllers.
  module ControllerExtensions
    def seo_page_data(data = nil, offset = 1)
      @seo_obj = data
      @request_offset = offset
    end
  end

  # To be used as View Helper tags.
  module Helpers

    def page_title
      return default_page_title unless @seo_obj && @seo_obj.title
      if @request_offset.present? && @request_offset.to_i > 1
        content_tag("title", "Page #{@request_offset} | #{@seo_obj.title.html_safe}")
      else
        content_tag("title", @seo_obj.title.html_safe)
      end
    end

    def default_page_title
      content_tag("title", SEO_PAGE_TITLE.html_safe)
    end

    def page_meta_description
      return '' unless @seo_obj && @seo_obj.meta_description
      tag("meta", :name => 'description', :content => @seo_obj.meta_description.html_safe)
    end

    def page_meta_keywords
      return '' unless @seo_obj && @seo_obj.meta_keywords
      tag("meta", :name => 'keywords', :content => @seo_obj.meta_keywords.html_safe)
    end

    def page_head_title
      return '' unless @seo_obj && @seo_obj.header_title
      content_tag(:h1, @seo_obj.header_title.html_safe, :class => ["h1-seo","hidden-xxs","hidden-xs","hidden-sm"])
    end

    def page_intro
      return '' unless @seo_obj && @seo_obj.intro
      content_tag("p", @seo_obj.intro.html_safe)
    end

    def page_section2
      return '' unless @seo_obj && @seo_obj.section2
      content_tag("p", @seo_obj.section2.html_safe)
    end

    def page_section3
      return '' unless @seo_obj && @seo_obj.section3
      content_tag("p", @seo_obj.section3.html_safe)
    end

    def page_end_para
      return '' unless @seo_obj && @seo_obj.end_para
      content_tag("p", @seo_obj.end_para.html_safe)
    end

  end

end
