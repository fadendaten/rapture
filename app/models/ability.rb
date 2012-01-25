class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
    if !user.nil?
      define_base_abilities  if user.has_role?(:base)
      define_admin_abilities if user.has_role?(:admin)
      define_sudo_abilities  if user.has_role?(:sudo)
    end
  end
  
  def define_base_abilities
    can :read, :all
    cannot :manage, User
  end
  
  def define_admin_abilities
    can :manage, Customer
  end
  
  def define_sudo_abilities
    can :manage, :all
  end
  
end
