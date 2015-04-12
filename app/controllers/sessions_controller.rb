class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome #{user}"      
    else
      redirect_to :back, notice: "User does not exist or incorrect password!"
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    flash[:notice] = 'Logout successful.'
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end