module Polycon
    module Helpers
        def self.polycon_exist?()
            if not Dir.exist?(Dir.home << "/.polycon")
                warn "ADVERTENCIA: La carpeta '.polycon' no existe en el sistema"
                Dir.mkdir(Dir.home << "/.polycon")
                warn "se ha creado la carpeta '.polycon' en la carpeta #{Dir.home} para almacenar la informacion de la aplicacion"
            end
        end

        def self.validate_string(str)
            #verifico que el string no este vacio ni posea el caracteres no permitidos "/" y "\"
            not(str.gsub(" ","").empty? or str.include?("/") or str.include?("\\"))
        end

        def self.path() #shortcut to polycon file
            Dir.home << "/.polycon"
        end

        def self.format_string(str)
            str.gsub(" ","_")
            p str
        end
    end
end