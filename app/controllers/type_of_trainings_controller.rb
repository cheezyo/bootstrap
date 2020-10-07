class TypeOfTrainingsController < ApplicationController
  before_action :set_type_of_training, only: [:show, :edit, :update, :destroy]

  # GET /type_of_trainings
  # GET /type_of_trainings.json
  def index
    @type_of_trainings = TypeOfTraining.all
  end

  # GET /type_of_trainings/1
  # GET /type_of_trainings/1.json
  def show
  end

  # GET /type_of_trainings/new
  def new
    @type_of_training = TypeOfTraining.new
  end

  # GET /type_of_trainings/1/edit
  def edit
  end

  # POST /type_of_trainings
  # POST /type_of_trainings.json
  def create
    @type_of_training = TypeOfTraining.new(type_of_training_params)

    respond_to do |format|
      if @type_of_training.save
        format.html { redirect_to @type_of_training, notice: 'Type of training was successfully created.' }
        format.json { render :show, status: :created, location: @type_of_training }
      else
        format.html { render :new }
        format.json { render json: @type_of_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_of_trainings/1
  # PATCH/PUT /type_of_trainings/1.json
  def update
    respond_to do |format|
      if @type_of_training.update(type_of_training_params)
        format.html { redirect_to @type_of_training, notice: 'Type of training was successfully updated.' }
        format.json { render :show, status: :ok, location: @type_of_training }
      else
        format.html { render :edit }
        format.json { render json: @type_of_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_of_trainings/1
  # DELETE /type_of_trainings/1.json
  def destroy
    @type_of_training.destroy
    respond_to do |format|
      format.html { redirect_to type_of_trainings_url, notice: 'Type of training was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_of_training
      @type_of_training = TypeOfTraining.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def type_of_training_params
      params.require(:type_of_training).permit(:title)
    end
end
