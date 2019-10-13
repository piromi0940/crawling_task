require 'rails_helper'

RSpec.describe VolunteerOrganization, type: :model do
    let(:valid_organization_name) { { name: "パンキャン" } }
    let(:invalid_organization_name) { { name: "株式会社activo" } }
    let(:organization) { VolunteerOrganization.new(valid_organization_name) }
    let(:invalid_organization) { VolunteerOrganization.new(invalid_organization_name) }

    describe 'orgaznization_name_check' do
      context 'duplicate volunteer organization name' do
        it "is invalid" do
          VolunteerOrganization.create(valid_organization_name)
            expect(organization).not_to be_valid
        end
      end

      context 'organizations without recruitment info' do
        it 'is #undefinde_organization_job_offer' do
          VolunteerOrganization.create(invalid_organization_name)
          expect(invalid_organization.undefinde_organization_name).to eq ['この団体の求人情報はありません']
        end
      end
    end
end
