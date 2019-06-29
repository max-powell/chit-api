class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :chat_id, :created_at
  belongs_to :user, serializer: SenderSerializer

end
