class ScrapeRecruitmentInfosController < ApplicationController
  before_action :set_scrape_recruitment_info, only: [:show, :edit, :update, :destroy]

  def index
    @volunteer_organization = VolunteerOrganization.select("name")
    @scrape_recruitment_infos = ScrapeRecruitmentInfo.where(group: @volunteer_organization)
  end

  def show
  end

  def new
    @scrape_recruitment_info = ScrapeRecruitmentInfo.new
  end

  def edit
  end

  def top
  end

  def create
    @scrape_recruitment_info = ScrapeRecruitmentInfo.new(scrape_recruitment_info_params)

    respond_to do |format|
      if @scrape_recruitment_info.save
        format.html { redirect_to @scrape_recruitment_info, notice: 'Scrape recruitment info was successfully created.' }
        format.json { render :show, status: :created, location: @scrape_recruitment_info }
      else
        format.html { render :new }
        format.json { render json: @scrape_recruitment_info.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @scrape_recruitment_info.update(scrape_recruitment_info_params)
        format.html { redirect_to @scrape_recruitment_info, notice: 'Scrape recruitment info was successfully updated.' }
        format.json { render :show, status: :ok, location: @scrape_recruitment_info }
      else
        format.html { render :edit }
        format.json { render json: @scrape_recruitment_info.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @scrape_recruitment_info.destroy
    respond_to do |format|
      format.html { redirect_to scrape_recruitment_infos_url, notice: 'Scrape recruitment info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_scrape_recruitment_info
      @scrape_recruitment_info = ScrapeRecruitmentInfo.find(params[:id])
    end

    def scrape_recruitment_info_params
      params.require(:scrape_recruitment_info).permit(:title, :group, :content, :url)
    end
end
