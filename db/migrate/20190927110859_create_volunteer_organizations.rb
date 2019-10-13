class CreateVolunteerOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteer_organizations do |t|
      t.string :name

      t.timestamps
    end
  end
end
