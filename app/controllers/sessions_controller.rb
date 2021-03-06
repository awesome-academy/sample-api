class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      check_activated user
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def check_remember remember_me, user
    remember_me == Settings.checkbox.value ? remember(user) : forget(user)
  end

  def check_activated user
    if user.activated?
      log_in user
      check_remember params[:session][:remember_me], user
      redirect_back_or user
    else
      flash[:warning] = t ".not_activated"
      redirect_to root_url
    end
  end
end
