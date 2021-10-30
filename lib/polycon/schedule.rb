module Polycon
    module Schedule
        require 'prawn'
        TIME=["8-00","8-30","9-00","9-30","10-00","10-30","11-00","11-30","12-00","12-30","13-00","13-30","14-00","14-30","15-00","15-30","16-00","16-30","17-00","17-30","18-00","18-30"]

        def self.fileName(date)
            if date.length > 1
                Dir.home << "/.polycon_files/Schedule week #{date[0]}.pdf"
            else
                Dir.home << "/.polycon_files/Schedule day #{date[0]}.pdf"
            end
        end

        def self.create_file(list,date)
            # begin
                Prawn::Document.generate(self.fileName(date)) do |file|
                    file.table([
                        ["Hour/Day",*date],
                        self.create_columns(list)],
                        :cell_style => {:size => 8}, :header => true, :row_colors => ["BBCCCC","EEEEEE"]
                    )
                end
        #     rescue
        #         return false
        #     else
                return true
        #     end
        end

        def self.create_columns(list)
            # list.each do |key, value|
            #     # p "#{key} #{hour}"
            #     value.each do |obj|
            #         p obj.date, obj.prof
            #     end
            # end
            [TIME.inject([]) { |aux, hour|
                aux+=[
                    list.keys.inject(["#{hour}"]) { |info, key|
                        if list[key].empty? || list[key].select {|obj| obj.date == "#{key} #{hour}"}.empty?
                            info.push("a")
                        else
                            info.push("b")
                        end
                    }
                ]
            }]
        end
    end
end
