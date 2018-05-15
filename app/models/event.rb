class Event < ApplicationRecord
  belongs_to :store,   optional: true
  belongs_to :product, optional: true
end
