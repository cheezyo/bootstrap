class TrainingProgramsController < ApplicationController
  load_and_authorize_resource
  before_action :set_training_program, only: [:show, :edit, :update, :destroy]

  # GET /training_programs
  # GET /training_programs.json
  def index
    @training_programs = TrainingProgram.all
  end

  # GET /training_programs/1
  # GET /training_programs/1.json
  def show
  end

  # GET /training_programs/new
  def new
    @training_program = TrainingProgram.new
  end

  # GET /training_programs/1/edit
  def edit
  end

  # POST /training_programs
  # POST /training_programs.json
  def create
    @training_program = TrainingProgram.new(training_program_params)

    respond_to do |format|
      if @training_program.save
        format.html { redirect_to @training_program, notice: 'Training program was successfully created.' }
        format.json { render :show, status: :created, location: @training_program }
      else
        format.html { render :new }
        format.json { render json: @training_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_programs/1
  # PATCH/PUT /training_programs/1.json
  def update
    respond_to do |format|
      if @training_program.update(training_program_params)
        format.html { redirect_to @training_program, notice: 'Training program was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_program }
      else
        format.html { render :edit }
        format.json { render json: @training_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_programs/1
  # DELETE /training_programs/1.json
  def destroy
    @training_program.destroy
    respond_to do |format|
      format.html { redirect_to training_programs_url, notice: 'Training program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_program
      @training_program = TrainingProgram.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def training_program_params
      params.require(:training_program).permit(:prog_number, :prog_url, :prog_name)
    end
end
