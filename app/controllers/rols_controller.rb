class RolsController < ApplicationController
  before_action :set_rol, only: [:show, :edit, :update, :destroy]

  # GET /rols
  def index
    @rols = Rol.all
  end

  # GET /rols/1
  def show
  end

  # GET /rols/new
  def new
    @rol = Rol.new
  end

  # GET /rols/1/edit
  def edit
  end

  # POST /rols
  def create
    @rol = Rol.new(rol_params)

    if @rol.save
      redirect_to @rol, notice: 'Rol was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /rols/1
  def update
    if @rol.update(rol_params)
      redirect_to @rol, notice: 'Rol was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /rols/1
  def destroy
    @rol.destroy
    redirect_to rols_url, notice: 'Rol was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rol
      @rol = Rol.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rol_params
      params.require(:rol).permit(:name)
    end
end
