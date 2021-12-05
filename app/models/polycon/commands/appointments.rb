module Polycon
  module Commands
    module Appointments
      class Create < Dry::CLI::Command
        desc 'Create an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: true, desc: "Patient's name"
        option :surname, required: true, desc: "Patient's surname"
        option :phone, required: true, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-08-16 13-00" --professional="Alma Estevez" --name=Carlos --surname=Carlosi --phone=2213334567'
        ]

        def call(date: "", professional: "", name: "", surname: "", phone: "", notes: nil)
          #validate the parameters
          if not Polycon::Helpers.vali_date?(date) #validate the date
            warn "ERROR: La fecha \"#{date}\" no es una fecha valida"
            warn "Formato de fecha valido: \"AAAA-MM-DD HH-II\"\nEjemplo: \"2021-08-16 13-00\""
          else
            aux=Polycon::Helpers.validate_field('profesional'=>professional, 'nombre'=>name, 'apellido'=>surname, 'telefono'=>phone)
            if not aux.empty?
              warn aux
              warn "ejemplo del comando, \"\"2021-08-16 13-00\" --professional=\"Alma Estevez\" --name=Carlos --surname=Carlosi --phone=2213334567\""

            else #verify if the entyre path exist
              Polycon::Helpers.polycon_exist?                          #verify if ".polycon" folder exists
              if not Polycon::Models::Professional.exist?(professional) #verify if the professional folder exists
                warn "ERROR: El profesional \"#{professional}\" no se encuentra registrado en el sistema"
              elsif Polycon::Models::Appointment.exist?(professional, date)
                warn "ERROR: El profesional \"#{professional}\" ya posee una cita en la fecha #{date}"
              else
                newAppointment = Polycon::Models::Appointment.new(date, professional, name, surname, phone, notes)
                newAppointment.create_file
                puts "El archivo de la cita del profesional #{professional} el dia \"#{date}\" fue creado con exito"
              end
            end
          end
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show details for an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-08-16 13-00" --professional="Alma Estevez" # Shows information for the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date: "", professional: "")
          if not Polycon::Helpers.vali_date?(date) #validate the date in the case that enter an incorrect date fomat
            warn "ERROR: La fecha \"#{date}\" no es una fecha valida"
            warn "Formato de fecha valido: \"AAAA-MM-DD HH-II\"\nEjemplo: \"2021-08-16 13-00\""
          else
            Polycon::Helpers.polycon_exist? #verify if ".polycon" folder exists
            if not Polycon::Models::Professional.exist?(professional) #verify if the professional folder exists
              warn "ERROR: El profesional \"#{professional}\" no se encuentra registrado en el sistema"
            elsif not Polycon::Models::Appointment.exist?(professional, date)
              warn "ERROR: El profesional \"#{professional}\" no posee una cita en la fecha #{date}"
            else
              Polycon::Models::Appointment.show_file(professional, date)
            end
          end
        end
      end

      class Cancel < Dry::CLI::Command
        desc 'Cancel an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-08-16 13-00" --professional="Alma Estevez" # Cancels the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date: "", professional: "")
          if not Polycon::Helpers.vali_date?(date) #validate the date
            warn "ERROR: La fecha \"#{date}\" no es una fecha valida"
            warn "Formato de fecha valido: \"AAAA-MM-DD HH-II\"\nEjemplo: \"2021-08-16 13-00\""
          else
            Polycon::Helpers.polycon_exist? #verify if ".polycon" folder exists
            if not Polycon::Models::Professional.exist?(professional) #verify if the professional folder exists
              warn "ERROR: El profesional \"#{professional}\" no se encuentra registrado en el sistema"
            elsif not Polycon::Models::Appointment.exist?(professional, date)
              warn "ERROR: El profesional \"#{professional}\" no posee una cita en la fecha #{date}"
            else
              Polycon::Models::Appointment.cancel_appointment(professional, date)
            end
          end
        end
      end

      class CancelAll < Dry::CLI::Command
        desc 'Cancel all appointments for a professional'

        argument :professional, required: true, desc: 'Full name of the professional'

        example [
          '"Alma Estevez" # Cancels all appointments for professional Alma Estevez',
        ]

        def call(professional: "")
          Polycon::Helpers.polycon_exist? #verify if ".polycon" folder exists
          if not Polycon::Models::Professional.exist?(professional) #verify if the professional folder exists
            warn "ERROR: El profesional \"#{professional}\" no se encuentra registrado en el sistema"
          else
            Polycon::Models::Appointment.cancel_all_files(professional) 
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List appointments for a professional, optionally filtered by a date'

        argument :professional, required: true, desc: 'Full name of the professional'
        option :date, required: false, desc: 'Date to filter appointments by (should be the day)'

        example [
          '"Alma Estevez" # Lists all appointments for Alma Estevez',
          '"Alma Estevez" --date="2021-08-16" # Lists appointments for Alma Estevez on the specified date'
        ]

        def call(professional: "", date: nil)
          Polycon::Helpers.polycon_exist?                          #verify if ".polycon" folder exists
          if not Polycon::Models::Professional.exist?(professional) #verify if the professional folder exists
            warn "ERROR: El profesional \"#{professional}\" no se encuentra registrado en el sistema"
          else
            if (date) and (not Polycon::Helpers.vali_date?(date+" 11-14")) #validate the date
              warn "ERROR: La fecha \"#{date}\" no es una fecha valida"
              warn "Formato de fecha valido: \"AAAA-MM-DD\"\nEjemplo: \"2021-08-16\""
              exit
            end
            Polycon::Models::Appointment.list_appointments(professional,date)
          end
        end
      end

      class Reschedule < Dry::CLI::Command
        desc 'Reschedule an appointment'

        argument :old_date, required: true, desc: 'Current date of the appointment'
        argument :new_date, required: true, desc: 'New date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-08-16 13-00" "2021-08-16 14-00" --professional="Alma Estevez" # Reschedules appointment on the first date for professional Alma Estevez to be now on the second date provided'
        ]

        def call(old_date: "", new_date: "", professional: "")
          if (not Polycon::Helpers.vali_date?(new_date) or not Polycon::Helpers.vali_date?(old_date)) #validate the date in the case that enter an incorrect date fomat
            warn "ERROR: Una de las fechas ingresadas no es una fecha valida"
            warn "Formato de fecha valido: \"AAAA-MM-DD HH-II\"\nEjemplo: \"2021-08-16 13-00\""
          else
            Polycon::Helpers.polycon_exist?                                       #verify if ".polycon" folder exists
            if not Polycon::Models::Professional.exist?(professional)             #verify if the professional folder exists
              warn "ERROR: El profesional \"#{professional}\" no se encuentra registrado en el sistema"
            elsif not Polycon::Models::Appointment.exist?(professional, old_date) #verify if the old_date file exists
              warn "ERROR: El profesional \"#{professional}\" no posee una cita en la fecha #{old_date}"
            elsif Polycon::Models::Appointment.exist?(professional, new_date) #verify if the new_date file exists
              warn "ERROR: El profesional \"#{professional}\" ya posee una cita en la fecha #{new_date}"
            else
              Polycon::Models::Appointment.rename_file(professional, old_date, new_date)
            end
          end
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit information for an appointments'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: false, desc: "Patient's name"
        option :surname, required: false, desc: "Patient's surname"
        option :phone, required: false, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-08-16 13-00" --professional="Alma Estevez" --name="New name" # Only changes the patient\'s name for the specified appointment. The rest of the information remains unchanged.',
          '"2021-08-16 13-00" --professional="Alma Estevez" --name="New name" --surname="New surname" # Changes the patient\'s name and surname for the specified appointment. The rest of the information remains unchanged.',
          '"2021-08-16 13-00" --professional="Alma Estevez" --notes="Some notes for the appointment" # Only changes the notes for the specified appointment. The rest of the information remains unchanged.',
        ]

        def call(date: "", professional: "", **options)
          if not Polycon::Helpers.vali_date?(date) #validate the date in the case that enter an incorrect date fomat
            warn "ERROR: Una de las fechas ingresadas no es una fecha valida"
            warn "Formato de fecha valido: \"AAAA-MM-DD HH-II\"\nEjemplo: \"2021-08-16 13-00\""
          else
            aux= Polycon::Helpers.validate_field(options)
            if not aux.empty?
              warn aux
              warn "ejemplo del comando, \"\"2021-08-16 13-00\" --professional=\"Alma Estevez\" --name=\"nuevoNombre\" --surname=\"nuevoApellido\""
            else
              Polycon::Helpers.polycon_exist?                                       #verify if ".polycon" folder exists
              if not Polycon::Models::Professional.exist?(professional)             #verify if the professional folder exists
                warn "ERROR: El profesional \"#{professional}\" no se encuentra registrado en el sistema"
              elsif not Polycon::Models::Appointment.exist?(professional, date) #verify if the date file exists
                warn "ERROR: El profesional \"#{professional}\" no posee una cita en la fecha #{date}"
              else
                Polycon::Models::Appointment.edit_file(professional, date, options)
              end
            end
          end
        end
      end
    end
  end
end
