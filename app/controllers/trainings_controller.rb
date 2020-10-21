class TrainingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_training, only: [:show, :edit, :update, :destroy]

  # GET /trainings
  # GET /trainings.json
  def index
    if current_user.admin? 
      @trainings = Training.order(t_date: :desc)
    else
      @trainings = Training.where(user_id: current_user.id).order(t_date: :desc)
    end

  end

  # GET /trainings/1
  # GET /trainings/1.json
  def show
  end

  # GET /trainings/new
  def new
    @training = Training.new
      session[:return_to] ||= request.referer
  end

  # GET /trainings/1/edit
  def edit
      session[:return_to] ||= request.referer
  end

  # POST /trainings
  # POST /trainings.json
  def create
    @training = Training.new(training_params)
    @training.user_id = @current_user.id
    respond_to do |format|
      if @training.save
        format.html { redirect_to session.delete(:return_to), notice: 'Training was successfully created.' }
        format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainings/1
  # PATCH/PUT /trainings/1.json
  def update
    respond_to do |format|
      if @training.update(training_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Training was successfully updated.' }
        format.json { render :show, status: :ok, location: @training }
      else
        format.html { render :edit }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainings/1
  # DELETE /trainings/1.json
  def destroy
    @training.destroy
    respond_to do |format|
      format.html { redirect_to trainings_url, notice: 'Training was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def training_params
      params.require(:training).permit(:rating,:type_of_training_id, :time, :t_date, :coment_text, :user_id)
    end
end
