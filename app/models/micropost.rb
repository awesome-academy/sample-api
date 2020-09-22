class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true,
            length: {maximum: Settings.micropost.length_content}
  delegate :name, to: :user, prefix: true
  scope :feed, ->(user_ids){where user_id: user_ids}
  has_one_attached :image
end
