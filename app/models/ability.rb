class Ability
  include CanCan::Ability

  def initialize(user)

    # Handle the case where we don't have a current_user i.e. the user is a guest
    user ||= User.new

    if user.is? :sudo
        can :manage, :all
    elsif user.is? :publisher
        can :manage, News
    elsif user.is? :member
        can :read, :all
    else
        can :read, :all
    end

    # can :manage, :all if user.is? :sudo
    # can :read, :all if user.is? :sudo
    
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
