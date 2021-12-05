class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: {maximum: 45 too_long: "El nombre de usuario debe ser de maximo %{count} caracteres"}
  validates :password, presence: true, length: {in: 8..255 too_short: "La contraseña debe tener al menos %{count} caracteres"}
  
  belongs_to :rol
end
