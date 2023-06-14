class Trip < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_many :likes

  has_many_attached :images
  has_many :comments
  has_one :marker

  validates :title, presence: true
  validates :description, length: { minimum: 5 }

  scope :of_followed_users, -> (following_users) { where(user_id: following_users) }

end
