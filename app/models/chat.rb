class Chat < ApplicationRecord
  validates :title, presence: true

  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users

end
