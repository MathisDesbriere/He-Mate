class Trip < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many_attached :images
  has_many :comments

  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 5 }


end
