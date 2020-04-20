class LevelsController < ApplicationController
  load_and_authorize_resource
  before_action :set_level, only: [:show, :edit, :update, :destroy, :add_sticker, :delete_sticker ]

  # GET /levels
  # GET /levels.json
  def index
    @levels = Level.all
  end

  # GET /levels/1
  # GET /levels/1.json
  def show
  end

  # GET /levels/new
  def new
    @level = Level.new
  end

  # GET /levels/1/edit
  def edit
  end
   def add_sticker
    ps = PlayerSticker.new
    player = Player.find(params[:player_id])
    ps.player_id = params[:player_id]
    ps.sticker_id = params[:sticker_id]
    ps.save
    if Sticker.find(params[:sticker_id]).trophy?
      player.level_id = player.level.next_level
      player.save
      
    end
    redirect_to @level
  end

  def delete_sticker
    player = Player.find(params[:player_id])
    ps = PlayerSticker.where(player_id: params[:player_id], sticker_id: params[:sticker_id]).first
    ps.destroy
    if Sticker.find(params[:sticker_id]).trophy?
       player.level_id = player.level.prev_level
       player.save
    end
    redirect_to @level
  end
  # POST /levels
  # POST /levels.json
  def create
    @level = Level.new(level_params)

    respond_to do |format|
      if @level.save
        format.html { redirect_to @level, notice: 'Level was successfully created.' }
        format.json { render :show, status: :created, location: @level }
      else
        format.html { render :new }
        format.json { render json: @level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /levels/1
  # PATCH/PUT /levels/1.json
  def update
    respond_to do |format|
      if @level.update(level_params)
        format.html { redirect_to @level, notice: 'Level was successfully updated.' }
        format.json { render :show, status: :ok, location: @level }
      else
        format.html { render :edit }
        format.json { render json: @level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /levels/1
  # DELETE /levels/1.json
  def destroy
    @level.destroy
    respond_to do |format|
      format.html { redirect_to levels_url, notice: 'Level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_level
      @level = Level.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def level_params
      params.require(:level).permit(:name, :color, :next_level, :prev_level, :url)
    end
end
