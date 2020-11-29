class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :set_task, only: [:show, :edit, :update, :destroy, :add_progress]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    if params[:player_id].present?
      @player = Player.find( params[:player_id].to_i)
    end

    @task = Task.new
    @task.progress = 0
  end

  # GET /tasks/1/edit
  def edit
    @player = @task.player
    session[:return_to] ||= request.referer
  end
  def add_progress
    if @task.done?
       @task.done = false
       @task.done_date = nil 
    else
          @task.done = true
          @task.done_date = DateTime.now
    end
    @task.save
    redirect_to request.referrer
    
  end 
  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.done = false
    respond_to do |format|
      if @task.save
        
        format.html { redirect_to @task.player, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
       
        format.html { redirect_to session.delete(:return_to) , notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:coach_id, :task, :task_category_id, :player_id, :done, :done_date, :progress, :image, :remove_image)
    end
end
