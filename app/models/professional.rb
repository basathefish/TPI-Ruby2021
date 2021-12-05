class Professional < ApplicationRecord
    has_many :appointments
    
    validates :name, presence: { message: " is required"}, uniqueness: true

    def to_s
        "#{name}"
    end
end
