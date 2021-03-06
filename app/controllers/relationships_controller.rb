class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: :create
  before_action :find_relation, only: :destroy

  def create
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow @user

    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def find_user
    @user = User.find params[:followed_id]
    return if @user

    @error = t ".fail"
  end

  def find_relation
    @relationship = Relationship.find_by id: params[:id]
    return if @relationship

    @error = t ".fail"
  end
end
