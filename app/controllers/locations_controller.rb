class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    if params[:search].present?
      @locations = Location.near(params[:search], 50)#, :order => :distance)
    else
      @locations = Location.all
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @mapURL = map_url(@location.address)
    render :show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    
    respond_to do |format|
      if @location.save
        #store latest location in session (for testing)
        session[:last_location] = "#{@location.address}, visited by #{@location.user}"
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        #flash.now[:error] = "Could not save location"
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find_by_id(params[:id])
      #raise "Location doesn't exist!" if @location.nil?
      redirect_to locations_path, :notice => "Woops, that location doesn't exist?" if @location.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :latitude, :longitude, :user_id)
    end

  def map_url(address)
    #key = "AIzaSyCVK7CXD7aPEeqrFaYGmsYJst2ik3wbAZc"
    raise "maps_APIKEY env variable not defined" if ENV['maps_APIKEY'].nil?
    key = ENV['maps_APIKEY']
    url = "https://www.google.com/maps/embed/v1/place?key=#{key}&q="
    url << ERB::Util.url_encode(address)
  end
end
