class Professional < ApplicationRecord
    has_many :appointments, dependent: :restrict_with_error
    
    validates :name, :surname, presence: { message: " is required"}, length: {in: 3..45, too_long: "Must be %{count} charcters max"}
    validate :full_name

    def full_name
        if name.present? and surname.present?
            aux = Professional.where("name= ? and surname= ?", name, surname).first
            if aux
                errors.add("#{:name} and #{:surname}", " : The professional already exist") unless id == aux.id
            end
        end
    end

    def to_s
        "#{name} #{surname}"
    end
end
