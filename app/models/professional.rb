class Professional < ApplicationRecord
    has_many :appointments, dependent: :restrict_with_error
    
    validates :name, :surname, presence: { message: " is required"}, uniqueness: true, length: {in: 8..255, too_long: "Must be %{count} charcters max"}

    def to_s
        "#{name}"
    end
end
