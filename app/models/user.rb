class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: {case_sensitive: false}

  has_many :messages
  has_and_belongs_to_many :chats
end
