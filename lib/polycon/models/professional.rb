module Polycon
    module Models
        class Professional
            attr_accessor :name
            def initialize(name)
                @name=name
            end

            def create_folder()
                Dir.mkdir(Helpers.path<<"/#{@name}")
            end

            def self.exist?(name) #verify if a file w/ that name exists
                Dir.exist?(Helpers.path<<"/#{name}")
            end

            def self.rename_professional(old_name, new_name)
                File.rename(Helpers.path << "/#{old_name}" , Helpers.path << "/#{new_name}")
            end

            def self.list_professionals()
                if Dir.children(Helpers.path).empty?
                    puts "No hay profesionales cargados en el sistema actualmente"
                else
                    puts "Los profesionales registrados en el sistema son los siguientes:"
                    puts Dir.children(Helpers.path)
                end
            end

            def self.delete_professional(name)
                begin
                    Dir.delete(Helpers.path << "/#{name}") #"Dir.delete" produce an error if the file is not empty
                rescue SystemCallError
                    warn "ERROR: El directorio \"#{name}\", no se encuentra vacio, por lo que la eliminacion se vio interrumpida"
                else
                    puts "El directorio \"#{name}\" fue eliminado con exito"
                end
            end

            def has_appointments?()
                self.appointments.empty?
            end
        end
    end
end