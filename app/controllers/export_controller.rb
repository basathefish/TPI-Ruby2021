class ExportController < ApplicationController
    before_action :set_professional, only: [ :export_professional ]

    def export_professional
        if params.include?(:export) and !params[:export][:date].blank?

            date = params[:export][:date].to_date
            week = params[:export][:week].to_i
            day = Time.zone.local(date.year, date.month, date.day)

            if week.zero?
                appointments = Appointment.where("professional_id=?", @professional).where("date BETWEEN ? AND ?", day.beginning_of_day, day.end_of_day).all.order('date ASC')
            else
                dayWeek = day+6.days
                appointments = Appointment.where("professional_id=?", @professional).where("date BETWEEN ? AND ?", day.beginning_of_day, dayWeek.end_of_day).all.order('date ASC')
            end
            hash = AppointmentsUtils.date_to_hash(day, week)
            data = AppointmentsUtils.create_data(hash, appointments)
            
            p "----- ----- ----- ----- ----- ----- ----- ----- ----- ----- "
            data.each do |aux|
                p "#{aux}"
            end
            render 'one'
        else
            render 'one'
        end
    end

    def export_all
        if params.include?(:export) and !params[:export][:date].blank?
            date = params[:export][:date].to_date
            week = params[:export][:week].to_i
            day = Time.zone.local(date.year, date.month, date.day)

            if week.zero?
                appointments = Appointment.where("date BETWEEN ? AND ?", day.beginning_of_day, day.end_of_day).all.order('date ASC')
            else
                dayWeek = day+6.days
                appointments = Appointment.where("date BETWEEN ? AND ?", day.beginning_of_day, dayWeek.end_of_day).all.order('date ASC')
            end
            hash = AppointmentsUtils.date_to_hash(day, week)
            data = AppointmentsUtils.create_data(hash, appointments)
            
        else
            render 'all'
        end
    end

    private
        def set_professional
            @professional = Professional.find(params[:professional_id])
        end
end