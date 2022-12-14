class FeedbacksController < ApplicationController
  load_and_authorize_resource
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit
  end
  def generate_feedbacks
    if params[:c_id].blank? || params[:c_id].empty? 
      @coach = current_user

    else
      @coach = User.find(params[:c_id])
    end
     date1 = DateTime.parse("01-01-" + (DateTime.now - 12.years).year.to_s)
    if params[:age].blank? || params[:age].empty?
      @players = @coach.players
      @age = ""
    elsif params[:age] == "12"
      @players = @coach.players.where('age >= ?', date1 )
      @age = " under 12"

    elsif params[:age] == "13"
      @players = @coach.players.where('age <= ?', date1 )
      @age = " over 13"
    else
      @players = @coach.players
      @age = ""
    end

  end
  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)
    @coach = User.find(params[:coach_id])
    respond_to do |format|
      if @feedback.save
        
        UserMailer.send_feedback(@feedback, @coach).deliver
        format.html { redirect_to request.referrer, success: 'Feedback was successfully created and sent.' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @feedback }
      else
        format.html { render :edit }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feedback_params
      params.require(:feedback).permit(:coach_id, :coach, :player_id, :feed_back, :email_date)
    end
end
