class TestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  # GET /tests
  # GET /tests.json
  def index
    if  params[:group] == nil 
      redirect_to "/tests/all_tests"
    else
      @tests = Test.where(:test_group_id => params[:group]) 
      @group_id = params[:group].to_i
      @group = TestGroup.find(params[:group].to_i)
    end
   
  end

  def all_tests
    @tests = Test.order(test_score: :desc)
  end

  def toplist
    @junior_female = Test.where(:test_type => "Junior", :gender => "Female")
    @junior_male = Test.where(:test_type => "Junior", :gender => "Male")
    @senior_male = Test.where(:test_type => "Senior", :gender => "Male")
    @senior_female = Test.where(:test_type => "Senior", :gender => "Female")
  end
  
  def save_year
    year = DateTime.now.year - 1

    if params[:year].present? 
        year = params[:year].to_i
    end
    ex = Exercise.new 
    ex.save_year(year)
    redirect_to request.referrer

  end
  def avg 
    @players = Player.where(parent_email: nil)
    #@players_w_utr = @players.reject!{|p| ! p.got_utr_profile?}
    @player = Player.new
    arr = [16, 14, 15]
    @test = Test.find(arr)




    
  end
  # GET /tests/1
  # GET /tests/1.json
  def show
    
  end

  # GET /tests/new
  def new
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)

    respond_to do |format|
      if @test.save
        format.html { redirect_to @test, notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update

    respond_to do |format|
      if @test.update(test_params)
         

         set_test_score(@test)

        

        if params[:group] != nil
          format.html { redirect_to tests_url + "?group=" + params[:group], notice: 'Test was successfully updated.' }
        else
          format.html { redirect_to @test.player, notice: 'Test was successfully updated.' }
          format.json { render :show, status: :ok, location: @test }
        end
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    if params[:group_id].present? 
        redirect_to TestGroup.find(params[:group_id].to_i), notice: 'Test group was successfully destroyed.'
    else
     redirect_to tests_url, notice: 'Test was successfully destroyed.'
    end
  end

  def update_test_score
    if params[:group] == nil
      tests = Test.all 
      tests.each do |t|
        set_test_score(t)
      end
      #tests.update_all(:updated_at => DateTime.now)
      redirect_to tests_url, notice: 'Test was successfully updated.'
    else
      tests = Test.where(:test_group_id => params[:group]) 
      tests.each do |t|
        set_test_score(t)
      end
      #tests.update_all(:updated_at => DateTime.now)
      
      redirect_to tests_url + "?group=" + params[:group], notice: 'Test was successfully updated.'
    end 
    

    
    
  end
  private

    def set_test_score (t)
        gender = t.player.gender.downcase
        total_score = 0.0
        
        sprint = Test.get_sprint_score(gender)
        total_score += check_running_score(sprint, t.sprint.to_f)
     
        spider = Test.get_spider_score(gender)
        total_score += check_running_score(spider, t.spider.to_f)

        chins = Test.get_chins_score(gender)
        total_score += check_score(chins, t.chins.to_f)
      
        medisin = Test.get_throw_score(gender)
        fh = 0.00
        bh = 0.00
        fh = check_score(medisin, t.fh_throw.to_f)
        bh = check_score(medisin, t.bh_throw.to_f)
        total_score += (fh + bh )/ 2
        
        jump = Test.get_jump_score(gender)
        total_score += check_score(jump, t.jump.to_f)

        box = Test.get_box_score(gender)
        total_score += check_score(box, t.box.to_f) 

        pushups = Test.get_pushups_score(gender)
        total_score += check_score(pushups, t.pushups.to_f) 

        situps = Test.get_situps_score(gender)
        total_score += check_score(situps, t.situps.to_f) 

        stretch_front = Test.get_stretch_front_score(gender)
        total_score += check_score(stretch_front, t.front_stretch.to_f)

        stretch_back = Test.get_stretch_back_score(gender)
        total_score += check_score(stretch_back, t.back_stretch.to_f)

        beep = Test.get_beep_score(gender)
        total_score += check_score(beep, t.beep.to_f)

        t.test_score = total_score.round(2)
        t.save!
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:count, :sprint, :spider, :jump, :fh_throw, :bh_throw, :box, :player_id, :test_group_id, :chins, :situps, :pushups, :front_stretch, :back_stretch, :beep, :test_score, :gender, :age, :type, :program1, :program2)
    end

    def check_running_score(list, score)
      
      arr = list.to_a
      if score < arr.last[0] && score != 0.0
        a = arr.last[1]
      elsif score > arr.first[0] || score == 0.0
        a = 0
      else
        a = list[score]
      end

      return a
      
    end

    def check_score(list, score)
      arr = list.to_a
      
      if score > arr.last[0]
        a = arr.last[1]
      elsif score < arr.first[0]
        a = 0
      else
        a = list[score]
      end
      return a
        
    end
end
