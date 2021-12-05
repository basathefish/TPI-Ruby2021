class Appointment < ApplicationRecord
  validates :date, :name, :surname, :phone, presence: true
  validates :phone, numericality: { only_integer: true }

  # validador custom de professional+date

  belongs_to :professional
end
