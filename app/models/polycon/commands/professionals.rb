module Polycon
  module Commands
    module Professionals
      class Create < Dry::CLI::Command
        desc 'Create a professional'
        argument :name, required: true, desc: 'Full name of the professional'
        example [
          '"Alma Estevez"      # Creates a new professional named "Alma_Estevez"',
          '"Ernesto Fernandez" # Creates a new professional named "Ernesto_Fernandez"'
        ]

        def call(name: "", **)
          Polycon::Helpers.polycon_exist?           #verify if ".polycon" folder exists

          aux=Polycon::Helpers.validate_field('nombre'=>name) #step 1 validate the string
          if not aux.empty?
            warn aux
          elsif Polycon::Models::Professional.exist?(name) #step 2 verify if exist
            warn "ERROR: El nombre \"#{name}\" pertenece a un profesional ya existente en el sistema"
            
          else #if it's valid, then create the professional an then the folder with that name
            newProfessional = Polycon::Models::Professional.new(name)
            newProfessional.create_folder
            puts "El directorio de \"#{name}\" fue creado con exito"
          end
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a professional (only if they have no appointments)'
        argument :name, required: true, desc: 'Name of the professional'
        example [
          '"Alma Estevez"      # Deletes a new professional named "Alma Estevez" if they have no appointments',
          '"Ernesto Fernandez" # Deletes a new professional named "Ernesto Fernandez" if they have no appointments'
        ]

        def call(name: nil)
          Polycon::Helpers.polycon_exist?           #verify if ".polycon" folder exists
          if not Polycon::Models::Professional.exist?(name) #verify if the directory exist
            warn "ERROR: \"#{name}\" no pertenece a ningun profesional existente en el sistema"
          else 
            Polycon::Models::Professional.delete_professional(name) #the verification if the file is empty is inside the method
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List professionals'
        example [
          "          # Lists every professional's name"
        ]

        def call(*)
          Polycon::Helpers.polycon_exist?           #verify if ".polycon" folder exists
          Polycon::Models::Professional.list_professionals()
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a professional'
        argument :old_name, required: true, desc: 'Current name of the professional'
        argument :new_name, required: true, desc: 'New name for the professional'
        example [
          '"Alna Esevez" "Alma Estevez" # Renames the professional "Alna Esevez" to "Alma Estevez"',
        ]

        def call(old_name: "", new_name: "", **)
          Polycon::Helpers.polycon_exist?           #verify if ".polycon" folder exists

          if not Polycon::Models::Professional.exist?(old_name) #verify if the directory exist
            warn "ERROR: \"#{old_name}\" no pertenece a ningun profesional existente en el sistema"
          end

          aux=Polycon::Helpers.validate_field('nombre nuevo'=>new_name) #validate the newName
          if not aux.empty?
            warn aux
          else 
            Polycon::Models::Professional.rename_professional(old_name, new_name)
            puts "el nombre del directorio \"#{old_name}\" fue cambiado con exito por el nombre \"#{new_name}\""
          end
        end
      end
    end
  end
end
