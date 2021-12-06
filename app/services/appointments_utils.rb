class AppointmentsUtils
    def self.date_to_hash(days, week)
        if week.zero?
            range = days.to_date..days.to_date
        else
            range = days.to_date..(days + 6.days).to_date
        end
        hash = Hash[ range.map{
            |date| date.to_s
            }.collect { 
                |date_converted| [date_converted, [] ] 
            } ]
    end

    def self.create_data(hash, data)
        data.each do |dat|
            day = dat.date.to_date.to_s
            if hash.key?(day)
                hash[day].append(dat)
            end
        end
    end
end