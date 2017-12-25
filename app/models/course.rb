class Course < ApplicationRecord
  validates :title, :description, presence: true
end
