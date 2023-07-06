class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return unless user.present?

    can(:read, Recipe, user)
    can(:read, Food, user)
    can :update, Recipe, user_id: user.id
    can :destroy, Recipe, user_id: user.id
    can :destroy, Food, user_id: user.id
  end
end
