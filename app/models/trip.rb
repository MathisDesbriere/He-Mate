class Trip < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :markers, dependent: :destroy

  has_many_attached :images
  has_many :comments
  has_one :marker

  validates :title, presence: true
  validates :description, length: { minimum: 5 }
  validate :validate_dates

  private

  def validate_dates
    return unless start_date && end_date

    errors.add(:end_date, "must be after start date") if end_date <= start_date
  end
end
