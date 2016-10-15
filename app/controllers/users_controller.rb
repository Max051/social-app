class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit,:update,:destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
        helper_method :set_user
  def index
     @users = User.paginate(page: params[:page])
  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to root_path
    end
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  def create
    @user = User.new(user_params)

    if @user.save
      Cloudinary::Uploader.upload("#{@original_filename}", public_id: "#{@user.id}-avatar")
      @user.send_activation_email
      flash[:info] = "Please check your email"
      redirect_to root_url
    else
      render 'new'
    end
  end
  def edit
      @user = User.find(params[:id])
  end
  def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
          flash[:danger] = "Edited successfuly!"
          redirect_to @user
  else
    render 'edit'
  end
    end
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "Destroyed succesfully"
      redirect_to user_url
    end
    def following
  @title = "Following"
  @user  = User.find(params[:id])
  @users = @user.following.paginate(page: params[:page])
  render 'show_follow'
end

def followers
  @title = "Followers"
  @user  = User.find(params[:id])
  @users = @user.followers.paginate(page: params[:page])
  render 'show_follow'
end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
  # Confirms the correct user.
   def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def admin_user
      unless current_user.admin?
          redirect_to root_url
      end



    end
end
