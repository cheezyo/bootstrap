class UserPlayersController < ApplicationController
load_and_authorize_resource

def create
    @user_player = UserPlayer.new(user_player_params)

    
      if @user_player.save
      	
     	redirect_to request.referrer, notice: 'Player was successfully created.'
        
      else
     	 redirect_to request.referrer, notice: 'Player was updatet.'
       
      end

  end
def update

    
      if @user_player.update(user_player_params)
      	
     	redirect_to request.referrer, notice: 'User was successfully created.'
        
      else
     	 redirect_to request.referrer, notice: 'User was updatet.'
       
      end

  end


  def destroy
  	 @user_player = UserPlayer.find(params[:id])
      @user_player.destroy
  	 redirect_to request.referrer, notice: 'profile deleted'
  end
private 

 def user_player_params
      params.require(:user_player).permit(:user_id, :player_id)
end


end