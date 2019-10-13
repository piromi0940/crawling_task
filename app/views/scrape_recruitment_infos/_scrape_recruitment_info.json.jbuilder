json.extract! scrape_recruitment_info, :id, :title, :group, :content, :url, :created_at, :updated_at
json.url scrape_recruitment_info_url(scrape_recruitment_info, format: :json)
