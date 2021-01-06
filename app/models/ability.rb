# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
       user ||= User.new # guest user (not logged in)
        #can :create, User
   
      can [:create, :new, :sign_up], User
      can :queue, Stringing
      can [:show, :update], User, id: user.id
    if user.admin? || user.coach? # additional permissions for administrators
          can :manage, :all

    end
    if user.player?  # additional permissions for logged in users 
      can [:show, :update], User, id: user.id
      cannot :create, User
      can [:show, :update], Player, player_profile: user
      can :toplist, Test
      can :show, Tournament
      can [:create, :update, :index, :destroy], Training

     end  
      if user.parent? 
      can [:show, :update], User, id: user.id
      can [:show, :update], Player, parent: user 
      can :toplist, Test
      can :show, Tournament
      end

      if user.receptionist?
        can [:show, :update], User, id: user.id
        can :manage, Stringing
      end
    
  



    
  can :assign_roles, User if user.admin?
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
