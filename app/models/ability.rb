class Ability
  include CanCan::Ability

  def initialize(current_user)
    return unless current_user.present?

    can :manage, Group, user: current_user
    can :manage, Expense, user: current_user
    can :manage, GroupExpense do |group_expense|
      group_expense.group.user == current_user
    end
  end
end
