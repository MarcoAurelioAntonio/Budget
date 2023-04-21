class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    # Handle the case where we don't have a current_user i.e. the user is a guest
    user ||= User.new_guest

    # Define a few sample abilities
    can :read, Recipe, public: true
    can :manage, Food
    can :manage, RecipeFood

    if user.admin?
      can :manage, :all
      puts 'Admin'
    elsif user.guest?
      cannot :create, Recipe
      cannot :read, Recipe, public: false
      can :read, Recipe, public: true
      puts 'Guest'
    elsif user.user?
      can %i[read update], User, id: user.id
      can :read, Recipe, user_id: user.id
      can :destroy, Recipe, user_id: user.id
      can :create, Recipe
      can :update, Recipe, user_id: user.id
    end
  end
end
