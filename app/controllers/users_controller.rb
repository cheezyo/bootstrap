class UsersController < ApplicationController
   load_and_authorize_resource :except => [:new]
   #skip_before_action :configure_permitted_parameters, only: [:create, :new]
   skip_before_action :authorized, only: [:new, :create, :register]
	 before_action :set_user, only: [:show, :edit, :update, :destroy]
	 #before_action :check_if_admin, except: [:new, :create]
  def index
    if params[:role] == "parent"
      @users = User.where(parent: :true)
    elsif params[:role] == "coach"
      @users = User.where(coach: :true).or(User.where(admin: :true))
    else
       @users = User.where(coach: :false, admin: :false, parent: :false)
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
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
      	sign_in(@user) unless current_user.admin? 
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :admin, :coach, :parent)
    end

    def check_if_admin
    	if !current_user.admin && current_user != @user 
    		redirect_to current_user
    		 
    	end

    end

end