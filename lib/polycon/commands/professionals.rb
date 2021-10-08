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

        def call(name:, **)
          Polycon::Helpers.polycon_exist?           #verify if ".polycon" folder exists
          if not Polycon::Helpers.validate_string(name) #step 1 validate the string
            warn "el nombre ingresado no es un nombre valido"
          elsif Polycon::Models::Professional.exist?(name) #step 2 verify if exist
            warn "el nombre ingresado pertenece a un profesional ya existente en el sistema"
            
          else #if it's valid, then create the professional an then the folder with that name
            newProfessional = Polycon::Models::Professional.new(name)
            newProfessional.create_folder
            puts "El directorio de #{name} fue creado con exito"
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
            warn "el nombre ingresado no pertenece a ningun profesional existente en el sistema"
          else 
            Polycon::Models::Professional.delete_professional(name)
          end
          #warn "TODO: Implementar borrado de la o el profesional con nombre '#{name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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

        def call(old_name:, new_name:, **)
          Polycon::Helpers.polycon_exist?           #verify if ".polycon" folder exists
          
          Polycon::Models::Professional.update_professional(name)
          #warn "TODO: Implementar renombrado de profesionales con nombre '#{old_name}' para que pase a llamarse '#{new_name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
