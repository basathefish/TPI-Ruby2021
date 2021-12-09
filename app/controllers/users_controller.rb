class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    redirect_if_not_logged_or_admin
    @users = User.all
  end

  # GET /users/1
  def show
    redirect_if_not_logged_or_admin
  end

  # GET /users/new
  def new
    redirect_if_not_logged_or_admin
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    redirect_if_not_logged_or_admin
  end

  # POST /users
  def create
    redirect_if_not_logged_or_admin
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    redirect_if_not_logged_or_admin
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    redirect_if_not_logged_or_admin
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :rol_id)
    end
    
    def redirect_if_not_logged_or_admin
      if session[:user_id].nil?
        redirect_to login_path
      else
        if current_user.rol.name != "administracion"
          redirect_to root_path
        end
      end
    end
end
