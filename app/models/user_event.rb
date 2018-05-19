class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :histories, dependent: :destroy
end
