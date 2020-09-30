class TournamentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_tournament, only: [:show, :edit, :update, :destroy, :add_player_to_tournament]

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all
  end
  def next_52_weeks

  end
  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
    @tournament.start_date = params[:start_date]
    @tournament.end_date = params[:end_date]
    session[:return_to] ||= request.referer
  end


  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(tournament_params)

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to session.delete(:return_to), notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_player_to_tournament 
    players = Player.find(params[:player_ids])
     players.each do |player|
      pt = PlayerTournament.new 
      pt.player_id = player.id
      pt.tournament_id = @tournament.id
      pt.save
     end
      redirect_to @tournament, notice: "Players added"
  end

  def remove_player_from_tournament
    player = Player.find(params[:player_id])
    tournament = Tournament.find(params[:tournament_id])

    PlayerTournament.where(player_id: player.id, tournament_id: tournament.id).first.destroy
    redirect_to tournament, notice: 'Player was successfully removed.'
  end


  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), notice: 'Tournament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tournament_params
      params.require(:tournament).permit(:title, :url, :u11, :u12, :u13, :u14, :u15, :u16, :u19, :start_date, :end_date, :club_trip, :only_coach, :user_id, :senior, :u10, :u18, :u17, :pluss, :flight_hotel, :commet)
    end
end
