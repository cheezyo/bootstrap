class PlayersController < ApplicationController
  load_and_authorize_resource
  before_action :set_player, only: [:show, :edit, :update, :destroy, :ironman_player ]

  # GET /players
  # GET /players.json
  def index
    arkiv = Planet.where(title: "Arkiv").first.id
    @players = Player.where.not(planet_id: arkiv)
  end



  # GET /players/1
  # GET /players/1.json
  def show
    age = (DateTime.now.year - @player.age.year)
    age_str = "u" + age.to_s
    if age < 19 
      @sym = age_str.to_sym
    else
      @sym = :senior
    end

    @tournaments = Tournament.where(age_str, true)
    

    @tasks = @player.tasks.where(done: false)
    @completed_tasks = @player.tasks.where(done: true)
    
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  def add_sticker
    ps = PlayerSticker.new
    @player = Player.find(params[:player_id])
    ps.player_id = params[:player_id]
    ps.sticker_id = params[:sticker_id]
    ps.save
    if Sticker.find(params[:sticker_id]).trophy?
      @player.level_id = @player.level.next_level
      @player.save
      
    end
    redirect_to @player
  end

  def delete_sticker
    @player = Player.find(params[:player_id])
    ps = PlayerSticker.where(player_id: params[:player_id], sticker_id: params[:sticker_id]).first
    ps.destroy
    if Sticker.find(params[:sticker_id]).trophy?
       @player.level_id = @player.level.prev_level
       @player.save
    end
    redirect_to @player
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ironman_player 

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:name, :age, :user_id, :level_id, :planet_id, :lastname, :gender )
    end
end
