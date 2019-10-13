class VolunteerOrganizationsController < ApplicationController
  before_action :set_volunteer_organization, only: [:show, :edit, :update, :destroy]

  def index
    @volunteer_organizations = VolunteerOrganization.all
  end

  def show
    @volunteer_organization = VolunteerOrganization.find_by(id: params[:id])
    @scrape_recruitment_info = ScrapeRecruitmentInfo.where(group: @volunteer_organization.name)
  end

  def new
    @volunteer_organization = VolunteerOrganization.new
  end

  def edit
  end

  def create
    @volunteer_organization = VolunteerOrganization.new(volunteer_organization_params)

    respond_to do |format|

      if @volunteer_organization.save
        format.html { redirect_to @volunteer_organization, notice: 'Volunteer organization was successfully created.' }
        format.json { render :show, status: :created, location: @volunteer_organization }
      else
        format.html { render :new }
        format.json { render json: @volunteer_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @volunteer_organization.update(volunteer_organization_params)
        format.html { redirect_to @volunteer_organization, notice: 'Volunteer organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @volunteer_organization }
      else
        format.html { render :edit }
        format.json { render json: @volunteer_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @volunteer_organization.destroy
    respond_to do |format|
      format.html { redirect_to volunteer_organizations_url, notice: 'Volunteer organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_volunteer_organization
      @volunteer_organization = VolunteerOrganization.find(params[:id])
    end

    def volunteer_organization_params
      params.require(:volunteer_organization).permit(:name)
    end
end
