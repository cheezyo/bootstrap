class UserPlayersController < ApplicationController
load_and_authorize_resource

def create
    @user_player = UserPlayer.new(user_player_params)

    
      if @user_player.save
      	
     	redirect_to Player.find(@user_player.player_id), notice: 'Player was successfully created.'
        
      else
     	 redirect_to users_path, notice: 'Player was updatet.'
       
      end

  end
def update

    
      if @user_player.update(user_player_params)
      	
     	redirect_to users_path, notice: 'User was successfully created.'
        
      else
     	 redirect_to users_path, notice: 'User was updatet.'
       
      end

  end


  def destroy
  	 @player.destroy
  	 redirect_to users_path, notice: 'profile deleted'
  end
private 

 def user_player_params
      params.require(:user_player).permit(:user_id, :player_id)
end


end