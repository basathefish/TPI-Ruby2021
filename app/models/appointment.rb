class Appointment < ApplicationRecord
  belongs_to :professional
  validates :date, :name, :surname, :phone, presence: true
  validates :phone, numericality: { only_integer: true }
  validate :hour_availability, :appointment_hour

  #round the minutes to 0 or 30
  def self.round_to_30_minutes(t)
    
  end

  #validate if the appointment's hour is between 8..20
  def appointment_hour
    if date.present?
      errors.add(:date, "hour must be bewween 8 and 20") unless ((8..20).include? date.hour)
      errors.add(:date, "minutes of the appointment must be 0 or 30") unless [0,30].include? date.min
    end
  end

  # validate if professional+date do ot exist in the database
  def hour_availability
    if date.present?

      # rounded = Time.at((date.to_time.to_i / 1800.0).round * 1800)
      # date= date.is_a?(DateTime) ? rounded.to_datetime : rounded

      aux = Appointment.where("date= ? and professional_id= ?", date, professional_id).first
      if aux
        errors.add(:date, " : The professional already has an appointment on that date and hour") unless id == aux.id
      end
    end
  end
end
