module Polycon
    module Helpers
        def self.polycon_exist?()
            if not Dir.exist?(Dir.home << "/.polycon")
                warn "ADVERTENCIA: La carpeta '.polycon' no existe en el sistema"
                Dir.mkdir(Dir.home << "/.polycon")
                warn "se ha creado la carpeta '.polycon' en la carpeta #{Dir.home} para almacenar la informacion de la aplicacion"
            end
        end

        def self.validate_field(hashs)
            #verify if the string is empty or if it has not valid characters "/" y "\"
            a=[]
            hashs.each do |(key,value)|
                if (value.gsub(" ","").empty? or value.include?("/") or value.include?("\\"))
                    a << "ERROR: El parametro \"#{value}\", no es un \"#{key}\" valido"
                    #in case of a empty value or a value with "/" o "\", it adds the message to the array that goes back to the commands section
                end
            end
            return a
        end

        require 'date'
        def self.vali_date?(date)
            #in case that the parameter of the date has something out the format, like; "2021-09-16 13:00asd"
            if not date[16].nil?
                date=date[0..15]
            end
            DateTime._strptime(date,format="%Y-%m-%d %H:%M")
        end

        def self.array_week(date)
            date= Date.parse(date,format="%Y-%m-%d")
            aux= (date..date+6).map do |day| day.to_s end
            return aux
        end

        def self.path() #shortcut to polycon file
            Dir.home << "/.polycon"
        end
    end
end