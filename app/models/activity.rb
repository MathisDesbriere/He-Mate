class Activity < ApplicationRecord
  belongs_to :trip, optional: true
  belongs_to :activity, optional: true
end
