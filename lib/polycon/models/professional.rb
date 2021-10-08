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

            def update_professional(new_name)
                File.rename(f, Helpers.path + "/" + filename.capitalize + File.extname(f))
                p 'el nombre fue cambiado con exito'
            end

            def self.list_professionals()
                if Dir.children(Helpers.path).empty?
                    puts "No hay profesionales cargados en el sistema actualmente"
                else
                    puts "Los profesionales registrados en el sistema son los siguientes:"
                    puts Dir.children(Helpers.path)
                end
            end

            # def delete_professional(name)
            #     if prof = self.search_professional(name)
            #         if self.has_appointments?
            #             puts 'error debido a que el profesional #{name} posee turnos asignados'
            #         else
            #             @@professionals.reject{|prof| prof.name==name}
            #             puts 'profesional eliminado con exito'
            #         end
            #     else
            #         puts 'el profesional indicado no se encuentra registrado'
            #     end
            # end
            
            # def search_professional(name)
            #     @@professional.detect {|prof| prof.name==name}
            # end

            # def has_appointments?()
            #     self.appointments.empty?
            # end

            # def to_s()
            #     self.name
            # end
        end
    end
end