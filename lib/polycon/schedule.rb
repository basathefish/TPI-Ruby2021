module Polycon
    module Schedule
        require 'prawn'
        def self.fileName(date)
            if date.length > 1
                Dir.home << "/.polycon_files/#{date[0]}.pdf"
            else
                Dir.home << "/.polycon_files/#{date[0]}.pdf"
            end
        end

        def self.create_file(list,date)
            # begin
                Prawn::Document.generate(self.fileName(date)) do |file|
                    file.table([["Hour/Day",[date]]])
                end
        #     rescue
        #         return false
        #     else
                return true
        #     end
        end
    end
end
