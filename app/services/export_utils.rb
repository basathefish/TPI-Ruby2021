class ExportUtils
    require 'prawn'
    #times for the schedule-pdf
    TIME=["8-00","8-30","9-00","9-30","10-00","10-30","11-00","11-30","12-00","12-30","13-00","13-30","14-00","14-30","15-00","15-30","16-00","16-30","17-00","17-30","18-00","18-30","19-00","19-30","20-00"]

    def self.create_file(list,date)
        pdf = Prawn::Document.new 
        table = [["//Hour\nDay",*date]]      #row with the days
        table += self.create_table(table, pdf, list) #rows with data of the schedule
        # p table
        pdf.table(table, :header => true, :row_colors => ["BBDDEE","EEEEEE"], :cell_style => {:size => 10})
        pdf.render
    end

    def self.create_table( table, file, list)
        TIME.inject([]) { |aux, hour| #set the rows for the schedule
            aux+=[
                list.keys.inject(["#{hour}"]) { |info, day| #set the gridds {or the colums} for the schedule
                    if list[day].select { |data| data.date.strftime("%Y-%m-%d_%H-%M") == "#{day}_#{hour}"}.empty?
                        #if there is no appointment that "day hour" then put a blank space
                        info.push("")
                    else #else, put the info of that appointment
                        info.push(self.info_grid(file, list[day], day, hour))
                    end
                }]
        }
    end

    def self.info_grid(file, list, day, hour)
        aux= []
        list.select {|obj| obj.date.strftime("%Y-%m-%d %H-%M") == "#{day} #{hour}"}.map {|obj|
            aux << [obj.schedule_format]
        }
        p aux
        if aux==[]
            aux= [aux]
        end
        file.make_table(aux,:cell_style => {:size => 10, :width=>80})
    end
end