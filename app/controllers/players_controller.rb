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
    
    t1 = @player.tournaments.where(end_date: DateTime.now..DateTime::Infinity.new)
    t2 = @tournaments.where(end_date: DateTime.now..DateTime::Infinity.new)
    @tournament = nil  
   if ! t1.empty? && ! t2.empty?
    arr = Array.new
    arr << t1.order('start_date asc').first.start_date.strftime("%U").to_i
    arr << t2.order('start_date asc').first.start_date.strftime("%U").to_i
    if arr[0] > arr[1]
      @tournament = t2.first
    else
      @tournament = t1.first
    end  
   elsif t1.empty? && ! t2.empty?
    @tournament = t2.order('start_date asc').first

   elsif ! t1.empty? && t2.empty?
    @tournament = t1.order('start_date asc').first
   end
  if @player.got_user?
     @trainings_month = Array.new
     @trainings_year = Array.new
     @trainings_prev_month = Array.new
     @date = check_date
     #t = @player.user.trainings.where('t_date BETWEEN ? AND ? AND type_of_training ?', Date.today.at_beginning_of_month, Date.today.at_end_of_month)
      TypeOfTraining.all.each do |t|
        
        @trainings_prev_month << [t.title, @player.user.trainings.where(type_of_training: t.id).where('t_date BETWEEN ? AND ?', (@date - 1.month).at_beginning_of_month, (@date - 1.month).at_end_of_month).sum(:time)] 
        @trainings_month << [t.title, @player.user.trainings.where(type_of_training: t.id).where('t_date BETWEEN ? AND ?', @date.at_beginning_of_month, @date.at_end_of_month).sum(:time)] 
        @trainings_year << [t.title, @player.user.trainings.where(type_of_training: t.id).where('t_date BETWEEN ? AND ?', Time.parse('01-01-' + @date.year.to_s), Time.parse('31-12-' + @date.year.to_s)).sum(:time)] 
      end
      @month_line = Array.new
      (@date.at_beginning_of_month..@date.at_end_of_month).each do |d|
        @month_line << [d, @player.user.trainings.where(t_date: d).sum(:time)]
      end 

      @trainings_year_per_month = Array.new
      (1..12).each do |m|
        date1 = Time.parse('01-' + m.to_s + "-" + @date.year.to_s)
        @trainings_year_per_month << [date1.strftime("%B"), @player.user.trainings.where('t_date BETWEEN ? AND ?', date1, date1.at_end_of_month).sum(:time)] 
      end
   
    end

    @tasks = @player.tasks.where(done: false)
    @completed_tasks = @player.tasks.where(done: true)
      #results?year=last&Type=singles
    if @player.got_utr_profile? 
     stats = "https://agw-prod.myutr.com/v1/player/" + @player.utr_profile + "/stats?Months=12&Type=singles&resultType=myutr&fetchAllResults=true"
     matches = "https://agw-prod.myutr.com/v1/player/" + @player.utr_profile + "/results?year=last&Type=singles"
     @json_stats = HTTParty.get(stats, headers: {"Authorization" => get_token})
     @json_matches = HTTParty.get(matches, headers: {"Authorization" => get_token})
     @myutr = @json_stats.parsed_response["singlesUtr"].to_f
    end
      
    
  end
  def utr
  @player = Player.find(1) 
     if @player.got_utr_profile? 
     stats = "https://agw-prod.myutr.com/v1/player/" + @player.utr_profile + "/stats?Months=12&Type=singles&resultType=myutr&fetchAllResults=true"
     matches = "https://agw-prod.myutr.com/v1/player/" + @player.utr_profile + "/results?year=last&Type=singles"
     @json_stats = HTTParty.get(stats, headers: {"Authorization" => get_token})
     @json_matches = HTTParty.get(matches, headers: {"Authorization" => get_token})
     
    end


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

  def get_token 
    string = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJNZW1iZXJJZCI6IjEyOTQxMCIsImVtYWlsIjoiY2V6YXJzaW5jYW5AaG90bWFpbC5jb20iLCJWZXJzaW9uIjoiMSIsIkRldmljZUxvZ2luSWQiOiI0NzMyNTQ2IiwibmJmIjoxNjAxNDUyNzIzLCJleHAiOjE2MDQwNDQ3MjMsImlhdCI6MTYwMTQ1MjcyM30.phM9zNHzbAfqMQtcivh90nB6nfCeHWPGFbsCoQil6AA"
  end
  def check_date
    if params[:date].nil? 
      date = DateTime.now
    else
      date = DateTime.parse(params[:date])
    end

  end
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit( :utr_profile, :name, :age, :user_id, :level_id, :planet_id, :lastname, :gender )
    end
end
