class ScrapingMoshicom < ScrapeRecruitmentInfo
   class << self

      def website_clawling(moshicom_domein)
        last_page = (CrawlingTool.count_last_page(moshicom_domein,'strong',1).to_f / CrawlingTool.set_url_to_nokogiri(moshicom_domein).css('div.card-eventSingle').count.to_f).ceil(0)
        (1..last_page).each do |n|
            pagination_parsed_page = CrawlingTool.set_url_to_nokogiri("https://moshicom.com/search?keywords=&date_start=&date_end=&disciplines%5B8%5D=11&scale=0&sort=2&disp_limit=20&mode=1&fbclid=IwAR2YWuW737l0XaeGh08zHa-BBA6aSgJyIrks4rZjwm_XT5-bEl4gpagiEY8&page=#{n}")
            argument_moshicom_element_saving_process(pagination_parsed_page)
          n += 1
        end
      end

      def argument_moshicom_element_saving_process(pagination_parsed_page)
        pagination_parsed_page.css('div.card-eventSingle').each do |vol|
          volunteer = {url:  vol.css('a')[0].attributes["href"].value}
          parsed_page = CrawlingTool.set_url_to_nokogiri('https://moshicom.com' + volunteer[:url])
          save_moshicom_scraping_data_to_db(volunteer,parsed_page)
        end
      end

      def save_moshicom_scraping_data_to_db(volunteer,parsed_page)
        ScrapeRecruitmentInfo.find_or_create_by(url: volunteer[:url]) do |b|
          save_unsave_moshicom_element_only(b,parsed_page,volunteer)
        end
      end

      def save_unsave_moshicom_element_only(m,parsed_page,volunteer)
        m.title = parsed_page.css('h1')[0].text
        m.group = parsed_page.css('.user-name')[0].text
        m.content = parsed_page.css('.card-text')[0].text
        m.url = 'https://moshicom.com' + volunteer[:url]
      end

   end
end
