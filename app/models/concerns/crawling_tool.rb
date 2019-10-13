module CrawlingTool
  class << self
    def set_url_to_nokogiri(url)
      Nokogiri::HTML(HTTParty.get(url))
    end

    def make_volunteer_element(vol,title,group,content,http,url,number)
      {title: vol.css(title).text , group: vol.css(group).text,
        content: vol.css(content).text, url: http + vol.css(url)[number].attributes["href"].value}
    end

    def count_web_element_number(page,element,number)
      page.css(element)[number].text.to_i
    end

    def count_last_page(domein,tag,number)
      count_web_element_number(set_url_to_nokogiri(domein),tag,number)
    end

  end
end
