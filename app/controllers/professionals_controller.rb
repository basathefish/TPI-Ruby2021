class ProfessionalsController < ApplicationController
  before_action :set_professional, only: [:show, :edit, :update, :destroy]

  # GET /professionals
  def index
    redirect_if_not_logged
    @professionals = Professional.all
  end

  # GET /professionals/1
  def show
    redirect_if_not_logged
  end

  # GET /professionals/new
  def new
    redirect_if_not_logged
    @professional = Professional.new
  end

  # GET /professionals/1/edit
  def edit
    redirect_if_not_logged
  end

  # POST /professionals
  def create
    redirect_if_not_logged
    @professional = Professional.new(professional_params)

    if @professional.save
      redirect_to @professional, notice: 'Professional was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /professionals/1
  def update
    redirect_if_not_logged
    if @professional.update(professional_params)
      redirect_to @professional, notice: 'Professional was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /professionals/1
  def destroy
    redirect_if_not_logged
    p("----- ----- ----- ----- -----#{appointment_params["date(4i)"]} hours----- ----- ----- ----- -----")
    if @professional.destroy
      notice = "ERROR; The professional #{professional.name} #{professional.surname} has appointments"
    else
      notice = "The professional #{professional.name} #{professional.surname} was deleted successfully"
    end
    redirect_to professionals_url, notice: notice
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professional
      @professional = Professional.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def professional_params
      params.require(:professional).permit(:name, :surname)
    end
    
    def redirect_if_not_logged
      if session[:user_id].nil?
          redirect_to login_path
      end
    end

    def redirect_if_not_admin
      if current_user.rol.name != "administracion"
        redirect_to root_path
      end
    end
end
