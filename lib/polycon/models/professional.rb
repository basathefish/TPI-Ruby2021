module Polycon
    module Models
        class Professional
            attr_accessor :name
            @@professionals=[]
            def initialize(name)
                @name=name
                @appointments=[]
            end

            def self.create_professional(name)
                newProfessional=Professional.new(name)
                @@professionals <<newProfessional
                p "#{name} is the name'"
            end

            def update_professional(name,new_name)
                prof=self.search_professional(name)
                prof.name=new_name
                p 'el nombre fue cambiado con exito'
            end

            def self.list_professionals()
                @@professionals.each do |prof|
                    puts prof.name
                end
            end

            def delete_professional(name)
                if prof = self.search_professional(name)
                    if self.has_appointments?
                        puts 'error debido a que el profesional #{name} posee turnos asignados'
                    else
                        @@professionals.reject{|prof| prof.name==name}
                        puts 'profesional eliminado con exito'
                    end
                else
                    puts 'el profesional indicado no se encuentra registrado'
                end
            end
            
            def search_professional(name)
                @@professional.detect {|prof| prof.name==name}
            end

            def has_appointments?()
                self.appointments.empty?
            end
        end
    end
end