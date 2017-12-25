class Student < ApplicationRecord
  validates :name, :email, presence: true
end
