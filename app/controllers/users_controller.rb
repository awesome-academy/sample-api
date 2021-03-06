class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show create)
  before_action :find_user, except: %i(index create new)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.page params[:page]
  end

  def show
    @microposts = @user.microposts.page(params[:page]).per Settings.micro.page
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".new.check_email"
      redirect_to root_url
    else
      flash.now[:danger] = t ".new.error"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      flash[:danger] = t ".fails"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".destroy.user_deleted"
    else
      falsh[:danger] = t ".destroy.fail"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit User::USER_PERMIT
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".new.not_found"
    redirect_to root_url
  end
end
