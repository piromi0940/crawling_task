class CreateScrapeRecruitmentInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :scrape_recruitment_infos do |t|
      t.string :title
      t.string :group
      t.text :content
      t.string :url

      t.timestamps
    end
  end
end
