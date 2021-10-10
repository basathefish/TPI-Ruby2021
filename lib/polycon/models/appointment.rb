module Polycon
    module Models
        class Appointment
            attr_accessor
            def create_appointment()
                p 'creadeishon'
            end

            def self.list_appointments(prof)
                if Dir.children(Helpers.path << "/#{prof}").empty?
                    puts "No hay citas cargadas para el profesional \"#{prof}\" actualmente"
                else
                    puts "El profesional \"#{prof}\" posee las siguientes citas:"
                    #remuevo la extension ".paf" de los archivos para que solo muestre la fecha
                    puts Dir.children(Helpers.path << "/#{prof}").each {|file| file.slice! ".paf"}
                end
            end
        end
    end
end

