class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if @user.nil?
      redirect_to users_path, notice:  "There is no user with that id"
    else
      @confirmedRequests = @user.friendships.accepted
      @pendingRequests = @user.friendships.pending
      @requestsToAccept = @user.friendships.requested
      @rejectedRequests = @user.friendships.rejected
      render :show
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    unless current_user != @user
      respond_to do |format|
        if user_params[:username].nil? and @user == current_user and @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to users_url, notice: "Sorry, you cannot edit other users than yourself!"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    unless current_user != @user #if current_user == @user
      @user.destroy
      session[:user_id] = nil
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to users_url, notice: "Sorry, you cannot delete other users than yourself!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :phonenumber, :password, :password_confirmation)
    end
end
