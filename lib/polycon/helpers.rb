module Polycon
    module Helpers
        def self.polycon_exist?()
            if not Dir.exist?(Dir.home << "/.polycon")
                warn "ADVERTENCIA: La carpeta '.polycon' no existe en el sistema"
                Dir.mkdir(Dir.home << "/.polycon")
                warn "se ha creado la carpeta '.polycon' en la carpeta #{Dir.home} para almacenar la informacion de la aplicacion"
            end
        end

        def self.validate(hashs)
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

        def self.path() #shortcut to polycon file
            Dir.home << "/.polycon"
        end

        # def self.format_string(str)
        #     str.gsub(" ","_")
        #     p str
        # end
    end
end