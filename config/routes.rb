Rails.application.routes.draw do
  root 'scrape_recruitment_infos#index'
  get '/top', to: 'scrape_recruitment_infos#top'
  resources :volunteer_organizations
  resources :scrape_recruitment_infos
end
