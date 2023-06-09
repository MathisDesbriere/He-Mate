class Marker < ApplicationRecord
  belongs_to :trip, optional: true
  belongs_to :activity, optional: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
