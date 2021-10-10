module Polycon
    module Models
        class Appointment
            attr_accessor :date, :professional, :info
            def initialize(date, professional, name, surname, phone, notes=nil)
                @date=date
                @professional=professional
                @info={Apellido: surname, Nombre: name, Telefono: phone}
                if notes
                    @info["Notas"]= notes
                else
                    @info["Notas"]= ""
                end
            end

            def create_file()
                File.open(Helpers.path << "/#{@professional}/#{date}.paf",'w') do |appointment|
                    info.each {|(key,value)| appointment.puts "#{key}: #{value}"}
                end
            end

            def self.exist?(professional, date) #verify if a file w/ that name exists
                File.exist?(Helpers.path<<"/#{professional}/#{date}.paf")
            end

            def self.show_file(professional, date)
                File.readlines(Helpers.path << "/#{professional}/#{date}.paf").each do |line| puts line end 
            end

            def self.cancel_appointment(professional, date)
                begin
                File.delete(Helpers.path << "/#{professional}/#{date}.paf")
                rescue
                    warn "ERROR: No se ha podido cancelar la cita del profesional #{professional} para el dia #{date}"
                else
                    warn "Se ha eliminado la cita del profesional #{professional} para el dia #{date}"
                end
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

