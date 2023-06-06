class Trip < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 5 }

end
