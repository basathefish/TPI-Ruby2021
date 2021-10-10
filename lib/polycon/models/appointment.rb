module Polycon
    module Models
        class Appointment
            attr_accessor :date, :professional, :name, :surname, :phone, :notes
            def initialize(date, professional, name, surname, phone, notes=nil)
                @date=date
                @professional=professional
                @name=name
                @surname=surname
                @phone=phone
                @notes=notes
            end

            def create_file()
                appointment=File.new(Helpers.path << "/#{@professional}/#{date}.paf",'w')
                appointment.puts({'professional'=>@professional,
                    'surname'=>@surname,
                    'name'=>@name,
                    'phone'=>@phone,
                    'notes'=>@notes}.to_s.gsub(",","\n"))
                appointment.close
            end

            def self.exist?(professional, date) #verify if a file w/ that name exists
                File.exist?(Helpers.path<<"/#{professional}/#{date}.paf")
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

