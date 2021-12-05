class Professional < ApplicationRecord
    has_many :appointments, dependent: :restrict_with_error
    
    validates :name, presence: { message: " es requerido"}, uniqueness: true, length: {in: 8..255 too_long: "Debe ser de %{count} caracteres maximo"}

    def to_s
        "#{name}"
    end
end
