class CreateCrawlSites < ActiveRecord::Migration[5.2]
  def change
    create_table :crawl_sites do |t|
      t.string :class_name
      t.text :first_page_url

      t.timestamps
    end
  end
end
