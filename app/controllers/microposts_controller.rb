class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach params[:micropost][:image]
    if @micropost.save
      flash[:success] = t ".micropost_created"
      redirect_to root_url
    else
      @feed_items = []
      flash[:danger] = t ".fail"
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".micropost_deleted"
      redirect_to request.referer || root_url
    else
      flash[:danger] = t ".fail"
      redirect_to root_url
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.blank?
  end
end
