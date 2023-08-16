class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :avatar

  def avatar
    if object.avatar.attached?
      url_for(object.avatar)
    else
      nil
    end
  end
end
