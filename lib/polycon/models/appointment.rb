module Polycon
    module Models
        class Appointment
            attr_accessor :date, :prof, :info
            def initialize(date, prof, name, surname, phone, notes=nil)
                @date=date
                @prof=prof
                @info={surname: surname, name: name, phone: phone}
                if notes
                    @info["notes"]= notes
                else
                    @info["notes"]= ""
                end
            end

            def create_file()
                File.open(Helpers.path << "/#{@prof}/#{date}.paf",'w') do |appointment|
                    info.each {|(key,value)| appointment.puts "#{key}: #{value}"}
                end
            end

            def self.exist?(prof, date) #verify if a file w/ that name exists
                File.exist?(Helpers.path << "/#{prof}/#{date}.paf")
            end

            def self.show_file(prof, date)
                File.readlines(Helpers.path << "/#{prof}/#{date}.paf") 
            end

            def self.cancel_appointment(prof, date)
                begin
                File.delete(Helpers.path << "/#{prof}/#{date}.paf")
                rescue
                    return false
                else
                    return true
                end
            end

            def self.cancel_all_files(prof)
                if Dir.children(Helpers.path << "/#{prof}").empty?
                    warn "No hay citas cargadas para el profesional \"#{prof}\" actualmente"
                else
                    begin
                        Dir.children(Helpers.path << "/#{prof}").each {|file| File.delete(Helpers.path << "/#{prof}/#{file}")}
                    rescue
                        return false
                    else
                        return true
                    end
                end
            end

            def self.rename_file(prof, old_date, new_date)
                begin
                File.rename(Helpers.path << "/#{prof}/#{old_date}.paf",Helpers.path << "/#{prof}/#{new_date}.paf")
                rescue
                    return false
                else
                    return true
                end
            end

            def self.list_appointments(prof, date=nil)
                #remuevo la extension ".paf" de los archivos para que solo muestre las fechas
                if not date
                    Dir.children(Helpers.path << "/#{prof}").each {|file| file.slice! ".paf"}
                else
                    aux=[]
                    Dir.children(Helpers.path << "/#{prof}").each {|file|
                        if file.split(" ")[0] == date
                            aux << file.delete(".paf")
                        end
                    }
                    return aux
                end
            end

            def self.list_week(date,prof=nil)
                require 'date'
                aux={}
                date= Date.parse(date,format="%Y-%m-%d")
                (date..date+7).each {|dat|
                    aux[dat.to_s] = list_day(dat.to_s,prof)
                }
            end

            def self.list_day(date,prof=nil)
                begin
                    aux=[]
                    if not prof
                        Professional.list_professionals.each {|folder|
                            list_appointments(folder,date).each {|file| 
                                if file
                                    aux << (show_file(folder, file) << "professional: #{folder}")
                                end
                            }
                        }
                    else
                        list_appointments(prof,date).each {|file| 
                            if file
                                aux << (show_file(prof, file) << "professional: #{prof}")
                            end
                        }
                    end
                rescue
                    return false
                else
                    return *aux
                end
            end

            def self.edit_file(prof, date, options=nil)
                begin
                    aux={}
                    File.readlines(Helpers.path << "/#{prof}/#{date}.paf").each do |line|
                        aux[line.split(':')[0]]=line.split(':')[1]
                    end
                    options.each do |(key,value)|
                        aux[key.to_s]=value
                    end
                    File.open(Helpers.path << "/#{prof}/#{date}.paf",'w') do |appointment|
                        aux.each {|(key,value)| appointment.puts "#{key}: #{value}"}
                    end
                rescue
                    return false
                else
                    return true
                end
            end
        end
    end
end

