class UsersController < ApplicationController
   load_and_authorize_resource :except => [:new, :create]
   #skip_before_action :configure_permitted_parameters, only: [:create, :new]
   skip_before_action :authorized, only: [:new, :create]
	 before_action :set_user, only: [:show, :edit, :update, :destroy]
	 #before_action :check_if_admin, except: [:new, :create]
  def index
    @names = ["No profile", "Players","Parents", "Coaches", "Admins"]
    if params[:user_type] == "Parents"
      @users = User.where(parent: :true)
      @name = "Parents"
    elsif  params[:user_type] == "Coaches"
      @users = User.where(coach: :true)
      @name = "Coaches"
    elsif  params[:user_type] == "Admins"
      @users = User.where(admin: :true)
      @name = "Admins"
    elsif params[:user_type] == "Players"
      @users = User.where(coach: :false, admin: :false, parent: :false).reject{|u| ! u.got_profile?}
      @name = "Players"
    else  
       @users = User.where(coach: :false, admin: :false, parent: :false)
        @name = "No profile"
    end
  end

   def edit
     
   end

   def new 
    if current_user.present? && !current_user.admin?
      redirect_to current_user
    else
      @user = User.new
      render :layout => 'devise/sessions'
  end
   end

    def create
     if current_user.present? && !current_user.admin?
      redirect_to current_user
    else
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
        	sign_in(@user) unless current_user.present?
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { redirect_to new_user_path, notice: 'Password needs to match, please try again' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end
   def show 

   end

   def update
     if params[:user][:password].blank?
	  params[:user].delete(:password)
	  params[:user].delete(:password_confirmation)
	end
     if @user.update(user_params)
       redirect_to users_path
     else
       render 'edit'
     end
   end
  def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :admin, :coach, :parent, :lastname, :player)
    end

    def check_if_admin
    	if !current_user.admin && current_user != @user 
    		redirect_to current_user
    		 
    	end

    end

end