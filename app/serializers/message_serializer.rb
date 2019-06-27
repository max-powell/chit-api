class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :current_user?, :created_at
  belongs_to :user, serializer: SenderSerializer

  def current_user?
    !!(object.user == current_user)
  end
end
