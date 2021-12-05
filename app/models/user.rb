class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: {maximum: 45, too_long: "The username must be %{count} characters maximum"}
  validates :password, presence: true, length: {in: 8..255, too_short: "The password must be at least %{count} characters"}
  
  belongs_to :rol
end
