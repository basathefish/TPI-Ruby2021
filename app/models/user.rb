class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  
  belongs_to :rol
end
