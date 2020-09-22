module RelationshipsHelper
  def new_relation
    current_user.active_relationships.build
  end

  def find_relation
    current_user.active_relationships.find_by followed_id: @user.id
  end
end
