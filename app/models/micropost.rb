class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true,
            length: {maximum: Settings.micropost.length_content}
            
  delegate :name, to: :user, prefix: true
  has_one_attached :image
end
