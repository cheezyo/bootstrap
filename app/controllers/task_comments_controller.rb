class TaskCommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_task_comment, only: [:show, :edit, :update, :destroy]

  # GET /task_comments
  # GET /task_comments.json
  def index
    @task_comments = TaskComment.all
  end

  # GET /task_comments/1
  # GET /task_comments/1.json
  def show
  end

  # GET /task_comments/new
  def new
    @task_comment = TaskComment.new
    if params[:task_id].present?
      @task = Task.find( params[:task_id].to_i)
      session[:return_to] ||= request.referer

    else
      redirect_to root_url
    end
  end

  # GET /task_comments/1/edit
  def edit
     if params[:task_id].present?
      @task = Task.find( params[:task_id].to_i)
      session[:return_to] ||= request.referer

    else
      redirect_to root_url
    end
  end

  # POST /task_comments
  # POST /task_comments.json
  def create
    @task_comment = TaskComment.new(task_comment_params)
    @task_comment.user_id = current_user.id
    respond_to do |format|
      if @task_comment.save        
          format.html { redirect_to session.delete(:return_to), notice: 'Task comment was successfully created.' }
          format.json { render :show, status: :created, location: @task_comment }
      else
        format.html { render :new }
        format.json { render json: @task_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_comments/1
  # PATCH/PUT /task_comments/1.json
  def update
    
    respond_to do |format|
      if @task_comment.update(task_comment_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Task comment was successfully created.' }
        format.json { render :show, status: :created, location: @task_comment }
       
      else
        format.html { render :edit }
        format.json { render json: @task_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_comments/1
  # DELETE /task_comments/1.json
  def destroy
    @task_comment.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Task comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_comment
      @task_comment = TaskComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_comment_params
      params.require(:task_comment).permit(:comment, :user_id, :task_id, :image)
    end
end
