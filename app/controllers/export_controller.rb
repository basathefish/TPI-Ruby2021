class ExportController < ApplicationController
    before_action :set_professional, only: [ :export_professional ]

    def export_professional
        if params.include?(:export) and !params[:export][:date].blank?
            date = params[:export][:date].to_date
            week = params[:export][:week].to_i
            
        else
            render 'one'
        end
    end

    def export_all
        if params.include?(:export) and !params[:export][:date].blank?
            date = params[:export][:date].to_date
            week = params[:export][:week].to_i
            
        else
            render 'all'
        end
    end

    private
        def set_professional
            @professional = Professional.find(params[:professional_id])
        end
end