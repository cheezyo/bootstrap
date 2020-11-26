class PeriodizationsController < ApplicationController
  before_action :set_periodization, only: [:edit, :update, :destroy]

  # GET /periodizations
  # GET /periodizations.json
  def index
    planets = Periodization.all.pluck(:planet_id).uniq
    @planets = Planet.find(planets)
  end

  # GET /periodizations/1
  # GET /periodizations/1.json
  def show
    @planet = Planet.find(params[:id])
    @periodizations = @planet.periodizations.order(week: :asc)
  end

  # GET /periodizations/new
  def new
    @periodization = Periodization.new
  end

  # GET /periodizations/1/edit
  def edit
  end

  # POST /periodizations
  # POST /periodizations.json
  def create
    @periodization = Periodization.new(periodization_params)

    respond_to do |format|
      if @periodization.save
        format.html { redirect_to @periodization, notice: 'Periodization was successfully created.' }
        format.json { render :show, status: :created, location: @periodization }
      else
        format.html { render :new }
        format.json { render json: @periodization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periodizations/1
  # PATCH/PUT /periodizations/1.json
  def update
    respond_to do |format|
      if @periodization.update(periodization_params)
        format.html { redirect_to periodization_path(@periodization.planet.id), notice: 'Periodization was successfully updated.' }
        format.json { render :show, status: :ok, location: @periodization }
      else
        format.html { render :edit }
        format.json { render json: @periodization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periodizations/1
  # DELETE /periodizations/1.json
  def destroy
    @periodization.destroy
    respond_to do |format|
      format.html { redirect_to periodizations_url, notice: 'Periodization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_periodization
      @periodization = Periodization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def periodization_params
      params.require(:periodization).permit(:planet_id,:week, :tennis_focus, :tennis_intesity, :physical_focus, :physical_intesity)
    end
end
