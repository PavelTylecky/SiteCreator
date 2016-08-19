class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  autocomplete :hashtag, :tag
  ActsAsTaggableOn.delimiter = ' '
  
  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.paginate(page: params[:page], :per_page => 3).order('created_at DESC') #.includes
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end


  # GET /sites/new
  def new
    @site = Site.new
    @site.picture = Picture.new(user_id: current_user.id)
    @themes = Site.available_themes_with_names #callb!
    @menu = Site.available_menu_with_names #callb!
    @templates = Template.all
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params.deep_merge(user_id: current_user.id, picture_attributes: {user_id: current_user.id}))
    @site.hashtag_list.add(params[:site][:hashtags][0].split(' '))

    respond_to do |format|
      if @site.save
        format.html { redirect_to [@site], notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:theme, :menu_type, :title, :default_template_id, :description, picture_attributes: [ :public_id, :url ])
    end
end
