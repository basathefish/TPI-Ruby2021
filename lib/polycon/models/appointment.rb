module Polycon
    module Models
        class Appointment
            attr_accessor :date, :prof, :info
            def initialize(date, prof, name, surname, phone, notes=nil)
                @date=date
                @prof=prof
                @info={Apellido: surname, Nombre: name, Telefono: phone}
                if notes
                    @info["Notas"]= notes
                else
                    @info["Notas"]= ""
                end
            end

            def create_file()
                File.open(Helpers.path << "/#{@prof}/#{date}.paf",'w') do |appointment|
                    info.each {|(key,value)| appointment.puts "#{key}: #{value}"}
                end
            end

            def self.exist?(prof, date) #verify if a file w/ that name exists
                File.exist?(Helpers.path<<"/#{prof}/#{date}.paf")
            end

            def self.show_file(prof, date)
                File.readlines(Helpers.path << "/#{prof}/#{date}.paf").each do |line| puts line end 
            end

            def self.cancel_appointment(prof, date)
                begin
                File.delete(Helpers.path << "/#{prof}/#{date}.paf")
                rescue
                    warn "ERROR: No se ha podido cancelar la cita del profesional #{prof} para el dia #{date}"
                else
                    warn "Se ha eliminado la cita del profesional #{prof} para el dia #{date}"
                end
            end

            def self.cancel_all_files(prof)
                if Dir.children(Helpers.path << "/#{prof}").empty?
                    puts "No hay citas cargadas para el profesional \"#{prof}\" actualmente"
                else
                    begin
                        Dir.children(Helpers.path << "/#{prof}").each {|file| File.delete(Helpers.path << "/#{prof}/#{file}")}
                    rescue
                        warn "ERROR: No se ha podido cancelar todas las citas del profesional #{prof}"
                    else
                        warn "Se ha eliminado todas las citas del profesional #{prof}"
                    end
                end
            end

            def self.rename_file(prof, old_date, new_date)
                begin
                File.rename(Helpers.path << "/#{prof}/#{old_date}.paf",Helpers.path << "/#{prof}/#{new_date}.paf")
                rescue
                    warn "ERROR: No se ha podido reasignar la cita del profesional #{prof} para el dia #{new_date}, por favor, intente nuevamente"
                else
                    warn "Se ha modificado correctamente la cita del profesional #{prof} del dia #{old_date} para el dia #{new_date}"
                end
            end

            def self.list_appointments(prof, date=nil)
                #remuevo la extension ".paf" de los archivos para que solo muestre las fechas
                aux=Dir.children(Helpers.path << "/#{prof}").each {|file| file.slice! ".paf"}
                if aux.empty? #tiene citas?
                    puts "No hay citas cargadas para el profesional \"#{prof}\" actualmente"
                else
                    if not date
                        puts "El profesional \"#{prof}\" posee las siguientes citas:"
                        puts aux
                    else
                        puts "El profesional \"#{prof}\" posee las siguientes citas el dia #{date}:"
                        aux.each do |file|
                            puts file if file[0...10]==date
                        end
                    end
                end
            end
        end
    end
end

