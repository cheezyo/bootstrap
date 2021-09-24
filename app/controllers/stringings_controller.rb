class StringingsController < ApplicationController
  load_and_authorize_resource except: [:queue]
  before_action :set_stringing, only: [:pick_up, :show, :edit, :update, :destroy, :paid, :unpay, :done, :undo, :return_pick_up]

  # GET /stringings
  # GET /stringings.json
  def index
    @stringings = Stringing.all
  end

  # GET /stringings/1
  # GET /stringings/1.json
  def show
  end

  # GET /stringings/new
  def new
    @stringing = Stringing.new
  end

  # GET /stringings/1/edit
  def edit
  end
  def paid

    @stringing.paid = DateTime.now
    @stringing.payment_registration = current_user.id
    @stringing.save
    redirect_to request.referrer
  end

  def unpay
    @stringing.paid = nil
    @stringing.payment_registration = nil
    @stringing.save
    redirect_to request.referrer
  end

  def done
    @stringing.done = DateTime.now
    @stringing.done_by = current_user.id
    @stringing.save
    #UserMailer.racket_finish(@stringing).deliver
    redirect_to request.referrer
  end

  def undo
    @stringing.done = nil
    @stringing.done_by = nil
    @stringing.save
    redirect_to request.referrer
  end

  def pick_up
    
    @stringing.picked_up = true
    @stringing.delivered = current_user.id
    @stringing.save
    redirect_to stringings_path
  end
  def pick_ups
    @stringing.picked_up = true
    @stringing.delivered = current_user.id
    @stringing.save
    redirect_to stringings_path
  end

  def return_pick_up
    @stringing.picked_up = false
    @stringing.delivered = nil  
    @stringing.save
    redirect_to stringings_path
  end

  def queue
    render :layout => 'devise/sessions'
  end
  # POST /stringings
  # POST /stringings.json
  def create
    @stringing = Stringing.new(stringing_params)
    
    @stringing.registered_by = current_user.id
    respond_to do |format|
      if @stringing.save
        format.html { redirect_to stringings_url, notice: 'Stringing was successfully created.' }
        format.json { render :show, status: :created, location: @stringing }
      else
        format.html { render :new }
        format.json { render json: @stringing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stringings/1
  # PATCH/PUT /stringings/1.json
  def update
    respond_to do |format|
      if @stringing.update(stringing_params)
        format.html { redirect_to @stringing, notice: 'Stringing was successfully updated.' }
        format.json { render :show, status: :ok, location: @stringing }
      else
        format.html { render :edit }
        format.json { render json: @stringing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stringings/1
  # DELETE /stringings/1.json
  def destroy
    @stringing.destroy
    respond_to do |format|
      format.html { redirect_to stringings_url, notice: 'Stringing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stringing
      @stringing = Stringing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stringing_params
      params.require(:stringing).permit(:picked_up, :customer, :type_of_strings, :tension, :price, :done, :delivered, :pick_up, :paid, :registered_by, :payment_registration, :payment_type)
    end
end
