class ScrapingBlueshipJapan < ScrapeRecruitmentInfo
  class << self
      def website_clawling(blueshipjapan_domein)
          last_page = CrawlingTool.count_last_page(blueshipjapan_domein,'span',8)
          (0..last_page).each do |n|
            pagination_parsed_page = CrawlingTool.set_url_to_nokogiri("https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=1&order=desc&fbclid=IwAR3ojD9h2jIW91Wxwl6JSvP7-WH3HkhKcCRObl3D39Kjc7w1WSFhUy8DFp4&per_page=#{n}")
            argument_bluship_element_saving_process(pagination_parsed_page)
          n += 18
          end
      end

      def argument_bluship_element_saving_process(pagination_parsed_page)
        pagination_parsed_page.css('div.event_info').each do |vol|
            volunteer = {url:  vol.css('a')[0].attributes["href"].value}
            parsed_page = CrawlingTool.set_url_to_nokogiri(volunteer[:url])
            save_blueship_scraping_data_to_db(volunteer,parsed_page)
        end
      end

      def save_blueship_scraping_data_to_db(volunteer,parsed_page)
        ScrapeRecruitmentInfo.find_or_create_by(url: volunteer[:url]) do |b|
          save_unsave_blueship_element_only(b,parsed_page,volunteer)
        end
      end

      def save_unsave_blueship_element_only(b,parsed_page,volunteer)
        b.title = parsed_page.css('h1')[1].text
        b.group = parsed_page.css('span')[11].text
        b.content = parsed_page.css('p')[8].text
        b.url = volunteer[:url]
      end

    end
end
