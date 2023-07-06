class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    return unless user.present?

    # Users can read and create recipes
    can [:read, :create], Recipe

    # Users can read and create foods
    can [:read, :create], Food

    # A user can update their recipe
    can :update, Recipe, user_id: user.id

    # A user can toggle publicity on their recipe
    can :toggle_public, Recipe, user_id: user.id

    # A user can add a food to his recipe
    can [:add_food, :create_food], Recipe, user_id: user.id

    # Only a user can delete his recipe
    can :destroy, Recipe, user_id: user.id

    # Only a user can update and delete his food
    can [:update, :destroy], Food, user_id: user.id

  end
end
