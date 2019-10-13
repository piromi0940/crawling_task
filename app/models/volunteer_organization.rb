class VolunteerOrganization < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validate :undefinde_organization_name

    def undefinde_organization_name
     errors.add(:name, 'この団体の求人情報はありません') unless ScrapeRecruitmentInfo.find_by(group: name)
    end
end
