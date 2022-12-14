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
    @rating = @player.get_rating
    
    @tasks = @player.tasks.where(done: false).order(task_category_id: :asc)
    @completed_tasks = @player.tasks.where(done: true).order(task_category_id: :asc)

    @last_ironman = ""
    if @player.get_last_ironman != nil
      @last_ironman = @player.get_last_ironman 
    end

    @tournament_hash = tournament_hash(@player)
      @tournament = ""

    @tournament_hash.each do |t|
      if ! t[1][1].empty? 
        @tournament = Tournament.find(t[1][1].first)
        break
      end
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
        @trainings_year << [t.title, @player.user.trainings.where(type_of_training: t.id).where('t_date BETWEEN ? AND ?', (@date.beginning_of_month - 12.months), @date.at_end_of_month).sum(:time)] 
        #@trainings_year << [t.title, @player.user.trainings.where(type_of_training: t.id).where('t_date BETWEEN ? AND ?', Time.parse('01-01-' + @date.year.to_s), Time.parse('31-12-' + @date.year.to_s)).sum(:time)] 
      end
      @month_line = Array.new
      (@date.at_beginning_of_month..@date.at_end_of_month).each do |d|
        @month_line << [d, @player.user.trainings.where(t_date: d).sum(:time)]
      end 
      
      @trainings_year_per_month = Array.new
      @year_ago = @date.beginning_of_month - 12.months
      (0..12).each do |m|
          #date1 = Time.parse('01-' + m.to_s + "-" + @date.year.to_s)
          @trainings_year_per_month << [@year_ago.strftime("1-%b-%y"), @player.user.trainings.where('t_date BETWEEN ? AND ?', @year_ago.beginning_of_month, @year_ago.at_end_of_month).sum(:time)] 
          @year_ago = @year_ago + 1.month
      end
      @year_ago = @date.beginning_of_month - 12.months
      @month_table = @player.user.trainings.where('t_date BETWEEN ? AND ?', @date.at_beginning_of_month, @date.at_end_of_month)
      @year_table = @player.user.trainings.where('t_date BETWEEN ? AND ?', @year_ago, (@year_ago + 12.months).at_end_of_month)

   
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
    session[:return_to] ||= request.referer
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
    session[:return_to] ||= request.referer
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
    
    if Player.exists?(name: player_params['name'], parent_email: player_params['parent_email'], age: player_params['age'])
      if session[:return_to].nil?

        redirect_to request.referer, danger: player_params['name'] + ' is already in database'
      else
        redirect_to session.delete(:return_to), danger: player_params['name'] + ' is already in database'
      end
    else
      respond_to do |format|
        if @player.save
          
          if ! params[:coach_id].nil?
            up = UserPlayer.new
            up.player_id = @player.id
            up.user_id = params[:coach_id].to_i
            up.save!

          end

          if session[:return_to].nil?
            format.html { redirect_to request.referer, success: @player.name + ' was successfully created and added to your team' }
          else
            format.html { redirect_to session.delete(:return_to), success: 'Player was successfully created.' }        
            format.json { render :show, status: :created, location: @player }
          end
        else
          format.html { render :new }
          format.json { render json: @player.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        if session[:return_to].nil?
          format.html { redirect_to request.referer, success: 'Player was successfully updated.' }
        else
          format.html { redirect_to session.delete(:return_to), success: 'Player was successfully updated.' }
          format.json { render :show, status: :ok, location: @player }
        end
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
      format.html { redirect_to players_url, success: 'Player was successfully destroyed.' }
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
      params.require(:player).permit(:coach_id, :parent_email, :competitor, :utr_profile, :name, :age, :user_id, :level_id, :planet_id, :lastname, :gender )
    end


    def tournament_hash(player)
      age = (DateTime.now.year - player.age.year)
      t_hash = Hash.new
      today_week = DateTime.now.strftime("%U").to_i
      date = 4.weeks.ago(DateTime.now)
      start_week = today_week - 4
      end_week = start_week + 52
      age_str = ""

    if age >= 10 
      
      if age <= 19 
        age_str = "u" + age.to_s
        sym = age_str.to_sym
      else
        age_str = "senior"
        sym = :senior
      end
      age1 = age_str

      (start_week..end_week).each do |w|

        d = date.monday.strftime("%d")  + "." + date.strftime("%b")+ " - " + date.sunday.strftime("%d") + "." + date.sunday.strftime("%b")
        
        if date.year > DateTime.new.year && age_str != "senior" && age1 == age_str

          if age_str == "u19"
            age1 = "senior"
          else
            age1 = "u" + (age = age).to_s
          end

        end

        arr = Array.new
        
        
        arr << d
        trn_arr = Tournament.where(age1, true).where(:start_date => date.monday..date.sunday).pluck(:id)
        plr_arr = @player.tournaments.where(:start_date => date.monday..date.sunday).pluck(:id)
        arr << trn_arr + plr_arr
        if date.strftime("%U").to_i == 0 
          t_hash.store(52, arr)
        else
          t_hash.store(date.strftime("%U").to_i, arr)
        end
        
        date = 1.week.since(date)
      end
     

    end

    return t_hash
  end

end
