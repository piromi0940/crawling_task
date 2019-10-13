class ScrapeRecruitmentInfo < ApplicationRecord
  include CrawlingTool
    class << self
      def all_site_rerular_clawling(class_name,first_page_url)
          class_name.website_clawling(first_page_url)
      end

      def each_site_data_set_and_crawling
          CrawlSite.all.each do |site|
              class_name = eval("#{site.class_name}")
              first_page_url = site.first_page_url
              all_site_rerular_clawling(class_name,first_page_url)
          end
      end
      
    end
end
