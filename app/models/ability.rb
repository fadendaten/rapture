class Ability
  include CanCan::Ability

  def initialize(user)
    if !user.nil?
      define_base_abilities  if user.has_role?(:base)
      define_admin_abilities if user.has_role?(:admin)
      define_sudo_abilities  if user.has_role?(:sudo)
    end
  end
  
  def define_base_abilities
    can :read, :all
  end
  
  def define_admin_abilities
    define_base_abilities
    can :manage, Customer
  end
  
  def define_sudo_abilities
    define_admin_abilities
    can :manage, :all
  end
  
end
