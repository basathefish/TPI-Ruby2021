class Professional < ApplicationRecord
    validate :name, presence: true, uniqueness: true
end
