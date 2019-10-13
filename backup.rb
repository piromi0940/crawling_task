class ScrapeRecruitmentInfo < ApplicationRecord
    include Tool
   class << self

  def scraping_blueship_japan
    blueshipjapan_domein = 'https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=1&order=desc&fbclid=IwAR3ojD9h2jIW91Wxwl6JSvP7-WH3HkhKcCRObl3D39Kjc7w1WSFhUy8DFp4&per_page=1'
    last_page = count_web_element_number(set_url_to_nokogiri(blueshipjapan_domein),'span',8)
    (0..last_page).each do |n|
      pagination_parsed_page = set_url_to_nokogiri("https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=1&order=desc&fbclid=IwAR3ojD9h2jIW91Wxwl6JSvP7-WH3HkhKcCRObl3D39Kjc7w1WSFhUy8DFp4&per_page=#{n}")
      pagination_parsed_page.css('div.event_info').each do |vol|
        volunteer = {url:  vol.css('a')[0].attributes["href"].value}
        parsed_page = set_url_to_nokogiri(volunteer[:url])
          ScrapeRecruitmentInfo.find_or_create_by(url: volunteer[:url]) do |b|
            save_unsave_blueship_element_only(b,parsed_page,volunteer)
          end
      end
     n += 18
    end
  end

  def scraping_moshicom(moshicom_domein)
    # moshicom_domein = set_url_to_nokogiri("https://moshicom.com/search?keywords=&date_start=&date_end=&disciplines%5B8%5D=11&scale=0&sort=2&disp_limit=20&mode=1&fbclid=IwAR2YWuW737l0XaeGh08zHa-BBA6aSgJyIrks4rZjwm_XT5-bEl4gpagiEY8&page=1")
    last_page = (count_web_element_number(moshicom_domein,'strong',1).to_f / moshicom_domein.css('div.card-eventSingle').count.to_f).round
    (1..last_page).each do |n|
       pagination_parsed_page = set_url_to_nokogiri("https://moshicom.com/search?keywords=&date_start=&date_end=&disciplines%5B8%5D=11&scale=0&sort=2&disp_limit=20&mode=1&fbclid=IwAR2YWuW737l0XaeGh08zHa-BBA6aSgJyIrks4rZjwm_XT5-bEl4gpagiEY8&page=#{n}")
       pagination_parsed_page.css('div.card-eventSingle').each do |vol|
         volunteer = make_volunteer_element(vol,'a.two-four-lines','a.d-inline-block','p.two-lines',"https://moshicom.com",'a.two-four-lines',0)
          ScrapeRecruitmentInfo.find_or_create_by(url: volunteer[:url]) do |m|
            save_unsave_moshicom_element_only(m,volunteer)
          end
       end
    end
  end

#   def scraping_blueship_japan
#     blueshipjapan_domein = 'https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=1&order=desc&fbclid=IwAR3ojD9h2jIW91Wxwl6JSvP7-WH3HkhKcCRObl3D39Kjc7w1WSFhUy8DFp4&per_page=1'
#     last_page = count_web_element_number(set_url_to_nokogiri(blueshipjapan_domein),'span',8)
#     (0..last_page).each do |n|
#       pagination_parsed_page = set_url_to_nokogiri("https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=1&order=desc&fbclid=IwAR3ojD9h2jIW91Wxwl6JSvP7-WH3HkhKcCRObl3D39Kjc7w1WSFhUy8DFp4&per_page=#{n}")
#       pagination_parsed_page.css('div.event_info').each do |vol|
#         volunteer = {url:  vol.css('a')[0].attributes["href"].value}
#         parsed_page = set_url_to_nokogiri(volunteer[:url])
#           ScrapeRecruitmentInfo.find_or_create_by(url: volunteer[:url]) do |b|
#             save_unsave_blueship_element_only(b,parsed_page,volunteer)
#           end
#       end
#      n += 18
#     end
#   end

#   def scraping_activo
#     parsed_page = set_url_to_nokogiri
#   end

#   def set_url_to_nokogiri(url)
#      Nokogiri::HTML(HTTParty.get(url))
#   end

#   def make_volunteer_element(vol,title,group,content,http,url,number)
#      {title: vol.css(title).text , group: vol.css(group).text,
#       content: vol.css(content).text, url: http + vol.css(url)[number].attributes["href"].value}
#   end

#   def count_web_element_number(page,element,number)
#      page.css(element)[number].text.to_i
#   end

#   def save_unsave_moshicom_element_only(m,volunteer)
#     m.title = volunteer[:title]
#     m.group = volunteer[:group]
#     m.content = volunteer[:content]
#     m.url = volunteer[:url]
#   end

#   def save_unsave_blueship_element_only(b,parsed_page,volunteer)
#     b.title = parsed_page.css('h1')[1].text
#     b.group = parsed_page.css('span')[11].text
#     b.content = parsed_page.css('p')[8].text
#     b.url = volunteer[:url]
#   end

#   def set_scraping_website

#   end
 end
#  blueshipjapan_domein = 'https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=1&order=desc&fbclid=IwAR3ojD9h2jIW91Wxwl6JSvP7-WH3HkhKcCRObl3D39Kjc7w1WSFhUy8DFp4&per_page=1'
  scraping_moshicom('https://moshicom.com/search?keywords=&date_start=&date_end=&disciplines%5B8%5D=11&scale=0&sort=2&disp_limit=20&mode=1&fbclid=IwAR2YWuW737l0XaeGh08zHa-BBA6aSgJyIrks4rZjwm_XT5-bEl4gpagiEY8&page=1')
  # scraping_website_domein('https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=1&order=desc&fbclid=IwAR3ojD9h2jIW91Wxwl6JSvP7-WH3HkhKcCRObl3D39Kjc7w1WSFhUy8DFp4&per_page=1')
end
