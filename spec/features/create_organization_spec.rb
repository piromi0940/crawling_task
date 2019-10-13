require 'rails_helper'

feature "Create volunteer organization" do
    before :all do
        create :scrape_recruitment_info
    end
    scenario "Add a new volunteer organization" do
       visit new_volunteer_organization_url
            fill_in 'Name', with: '一般社団法人 阿賀町観光協会'
            click_button('新規登録')
            expect(page).to have_content 'Volunteer organization was successfully created.', '一般社団法人 阿賀町観光協会'
       visit root_path
            expect(page).to have_content '一般社団法人 阿賀町観光協会'
    end
    after :all do
        DatabaseCleaner.clean_with(:truncation)
    end
end
