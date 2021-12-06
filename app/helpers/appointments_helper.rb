module AppointmentsHelper
    def full_name(name, surname)
        "Paciente #{name} #{surname}"
    end

    def formadate(date)
        I18n.l(date, format: :long)
    end
end
