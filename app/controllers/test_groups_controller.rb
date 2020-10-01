class TestGroupsController < ApplicationController
  load_and_authorize_resource
  before_action :set_test_group, only: [:show, :edit, :update, :destroy, :add_player_to_group]

  # GET /test_groups
  # GET /test_groups.json
  def index
    @test_groups = TestGroup.all
  end

  # GET /test_groups/1
  # GET /test_groups/1.json
  def show
  end

  # GET /test_groups/new
  def new
    @test_group = TestGroup.new
  end

  # GET /test_groups/1/edit
  def edit
  end

  # POST /test_groups
  # POST /test_groups.json
  def create
    @test_group = TestGroup.new(test_group_params)

    respond_to do |format|
      if @test_group.save
        format.html { redirect_to @test_group, notice: 'Test group was successfully created.' }
        format.json { render :show, status: :created, location: @test_group }
      else
        format.html { render :new }
        format.json { render json: @test_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_groups/1
  # PATCH/PUT /test_groups/1.json
  def update
    respond_to do |format|
      if @test_group.update(test_group_params)
        format.html { redirect_to @test_group, notice: 'Test group was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_group }
      else
        format.html { render :edit }
        format.json { render json: @test_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_groups/1
  # DELETE /test_groups/1.json
  def destroy
    @test_group.destroy
    respond_to do |format|
      format.html { redirect_to test_groups_url, notice: 'Test group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   def add_player_to_group
      players = Player.find(params[:player_ids])
      players.each do |player|
        
        t = Test.new
        t.sprint = 0
        t.spider = 0
        t.jump = 0
        t.fh_throw = 0 
        t.bh_throw = 0
        t.box = 0 
        t.beep = 0
        t.chins = 0
        t.pushups = 0
        t.situps = 0
        t.front_stretch = 0
        t.back_stretch = 0
        t.player_id = player.id
        t.test_date = @test_group.date
        t.gender = player.gender.capitalize
        t.test_type = "Junior"
        age = @test_group.date.year - player.age.year 
        t.age = age
        if age > 19
          t.test_type = "Senior"
        end
        t.test_group_id = @test_group.id
        t.save

      
      end
      
      
      redirect_to @test_group, notice: "Players added to the group you can start test"
    end
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_group
      @test_group = TestGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def test_group_params
      params.require(:test_group).permit(:title, :date)
    end
end
