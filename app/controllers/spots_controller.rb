class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :set_country, except: [ :index ]
  before_action :set_spot_marker, only: [ :show, :edit ]
  before_action :require_login, only: [ :edit, :update, :destroy ]
  before_action :require_login_for_new, only: [ :new, :create ]

  # GET /spots
  # GET /spots.json
  def index
    @spots = Spot.all
    @markers = @spots.map do |s|
      [ s.id, s.name, s.latitude, s.longitude, country_spot_url(s.country, s) ]
    end
    gon.markers = @markers
  end

  # GET /spots/1
  # GET /spots/1.json
  def show
    @photos = @spot.photos.all
    @schools = @spot.schools.all
    gon.seasons = []
    @spot.seasons.each do |s|
      gon.seasons[s.sport.id] = s.get_months_array
    end


    if request.path != country_spot_path(@country, @spot)
      return redirect_to [@country, @spot], :status => :moved_permanently
    end
    
  end

  # GET /spots/new
  def new
    @spot = Spot.new
    @spot.name = 'New spot'
    @spot.latitude = 0
    @spot.longitude = 0
    @photos = @spot.photos.build
    #@seasons = @spot.seasons.build
    
    # passing markers and country name to gmaps js api
    
    gon.markers = [[ @spot.id, @spot.name, @spot.latitude, @spot.longitude, '']]
    gon.country = @country.name
    
  end

  # GET /spots/1/edit
  def edit
    @photos = @spot.photos.all
    if @spot.seasons.count < Sport.all.count 
      @seasons = @spot.seasons.build
    end
    #unless @photos.exists? 
     # @photos = Photo.create
    #end
  end

  # POST /spots
  # POST /spots.json
  def create
    @spot = Spot.new(spot_params)

    respond_to do |format|
      if @spot.save
        if params[:photos]
          params[:photos]['image'].each do |a|
            @photo = @spot.photos.create!(:image => a, :imageable_id => @spot.id)
          end
        end
        format.html { redirect_to [@country,@spot], notice: "Spot was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /spots/1
  # PATCH/PUT /spots/1.json
  def update
    respond_to do |format|
      if @spot.update(spot_params)
        if params[:photos]
          params[:photos]['image'].each do |a|
            @photo = @spot.photos.create!(:image => a, :imageable_id => @spot.id)
          end
        end

        format.html { redirect_to [ @country, @spot ] , notice: 'Spot was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /spots/1
  # DELETE /spots/1.json
  def destroy
    @spot.destroy
    redirect_to country_path(@country), notice: 'Spot was successfully destroyed.'
  end
  
### Private methods

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.friendly.find(params[:id])
    end
    
    def set_country
      @country = Country.friendly.find(params[:country_id])
    end
    
    def set_spot_marker
      gon.markers = [[ @spot.id, @spot.name, @spot.latitude, @spot.longitude, country_spot_url]]
      gon.country = @country.name
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spot_params
      params.require(:spot).permit(:name, :latitude, :longitude,  :country_id, 
        photos_attributes: [:id, :image, :imageable_id], seasons_attributes: [:id, :spot_id, :sport_id, :months])
    end
    
    def require_login
      unless logged_in?
        # flash[:error] = "You must be logged in to access this section"
        redirect_to country_spot_path( @country, @spot )
      end
    end
    
    def require_login_for_new
      unless logged_in?
        # flash[:error] = "You must be logged in to access this section"
        redirect_to root_path
      end
    end
    
end
