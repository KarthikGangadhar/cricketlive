class SeoSlug
  
  PAGE_TITLE_STUB = "Real Estate Agent"
  COMP_PAGE_TITLE_STUB = "Real Estate Agency"
  FIND_REALTOR_REG = "Find a REALTOR&reg;"
  REALTOR_TAG = "Realtor.com&reg;"
  DEFAULT_URL = "http://www.realtor.com/realestateagents/"

  attr_accessor :page_title
  attr_accessor :canonical_tag
  attr_accessor :page
  attr_accessor :page_metadescription
  attr_accessor :page_metakeyword
  attr_accessor :page_h1
  attr_accessor :page_intro
  attr_accessor :page_section2
  attr_accessor :page_section3
  attr_accessor :page_end

  def initialize params = {}
    @page = params[:pagename]
    @current_baseurl = 'realestateagents'
    seo_data = params[:seo_data]
    current_url = params[:current_url]

    if !current_url.blank?
      if current_url.include?('/realestateagents')
        @current_baseurl = 'realestateagents'
      elsif current_url.include?('/realestateteam')
        @current_baseurl = 'realestateteam'
      elsif current_url.include?('/realestateagency')
        @current_baseurl = 'realestateagency'
      end
    end

    if @page == 'profile'
      set_page_title(seo_data)
    elsif @page == 'company'
      set_company_page_title(seo_data)
    end
    set_canonical(seo_data)
  end

  def page_title
    @page_title || PAGE_TITLE_STUB
  end

  def canonical_tag
    @canonical_tag || DEFAULT_URL
  end

  private

  def set_page_title(data)
    if data.agent_name.present? && data.address.present?
      @page_title = "#{data.agent_name} - #{PAGE_TITLE_STUB} in #{data.address} #{FIND_REALTOR_REG} - #{REALTOR_TAG}"
    end
  end

  def set_company_page_title(data)
    if data.present?
      @page_title = "#{data.company_name} - #{COMP_PAGE_TITLE_STUB} in - #{FIND_REALTOR_REG} - #{REALTOR_TAG}"
    end
  end

  def set_canonical(data)
    case @page
    when 'home'
      @canonical_tag = nil
    when 'profile'
      if data.profile_url.present?
        @canonical_tag = data.profile_url
      end
    end
  end

end
