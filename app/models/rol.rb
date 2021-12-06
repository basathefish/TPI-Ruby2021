class Rol < ApplicationRecord
    has_many :users
    validates :name, presence: true, uniqueness: true

    def to_s
        "#{name.capitalize()}"
    end
end
