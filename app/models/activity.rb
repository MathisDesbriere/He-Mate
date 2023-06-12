class Activity < ApplicationRecord
  belongs_to :trip, optional: true
  belongs_to :marker, optional: true
  belongs_to :user
  accepts_nested_attributes_for :marker
end
