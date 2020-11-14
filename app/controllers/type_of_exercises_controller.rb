class TypeOfExercisesController < ApplicationController
  before_action :set_type_of_exercise, only: [:show, :edit, :update, :destroy]

  # GET /type_of_exercises
  # GET /type_of_exercises.json
  def index
  
    @type_of_exercises = TypeOfExercise.all
  end

  # GET /type_of_exercises/1
  # GET /type_of_exercises/1.json
  def show
  end

  # GET /type_of_exercises/new
  def new
    @type_of_exercise = TypeOfExercise.new
  end

  # GET /type_of_exercises/1/edit
  def edit
  end

  # POST /type_of_exercises
  # POST /type_of_exercises.json
  def create
    @type_of_exercise = TypeOfExercise.new(type_of_exercise_params)

    respond_to do |format|
      if @type_of_exercise.save
        format.html { redirect_to @type_of_exercise, notice: 'Type of exercise was successfully created.' }
        format.json { render :show, status: :created, location: @type_of_exercise }
      else
        format.html { render :new }
        format.json { render json: @type_of_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_of_exercises/1
  # PATCH/PUT /type_of_exercises/1.json
  def update
    respond_to do |format|
      if @type_of_exercise.update(type_of_exercise_params)
        format.html { redirect_to @type_of_exercise, notice: 'Type of exercise was successfully updated.' }
        format.json { render :show, status: :ok, location: @type_of_exercise }
      else
        format.html { render :edit }
        format.json { render json: @type_of_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_of_exercises/1
  # DELETE /type_of_exercises/1.json
  def destroy
    @type_of_exercise.destroy
    respond_to do |format|
      format.html { redirect_to type_of_exercises_url, notice: 'Type of exercise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_of_exercise
      @type_of_exercise = TypeOfExercise.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def type_of_exercise_params
      params.require(:type_of_exercise).permit(:title)
    end
end
