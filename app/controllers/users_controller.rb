class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @all_visible_recipes_of_user = @user.recipes.visible
    @all_invisible_recipes_of_user = @user.recipes.invisible
  end

  # GET /users/new
  def new
    redirect_to users_path unless is_authenticated?
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to :login, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def login
    redirect_to users_path unless is_authenticated?
  end

  def attempt_to_login
    if params[:password].blank? || params[:email].blank?
      flash[:error] = "Password or email was incorrect, please try again"
      redirect_to login_path
      return
    end

    password = params[:password]
    found_user = User.where(:email => params[:email]).first

    authorized_user = found_user.authenticate(password) unless found_user.nil?
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:user_name] = authorized_user.fullname
      redirect_to users_path, :notice => "Login successful"
    else
      flash[:error] = "Password or email was incorrect, please try again"
      render 'login'
    end

  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to login_path, :notice => "Logout successful"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :bio)
    end

    def is_authenticated?
      session[:user_id].blank? || session[:user_name].blank?
    end

end
