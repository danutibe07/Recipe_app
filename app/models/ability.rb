class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    return unless user.present?

    # Users can read and create recipes
    can %i[read create], Recipe

    # Users can read and create foods
    can %i[read create], Food

    # A user can update their recipe
    can :update, Recipe, user_id: user.id

    # A user can toggle publicity on their recipe
    can :toggle_public, Recipe, user_id: user.id

    # A user can add and remove their recipe ingredients
    can %i[add_ingredient create_ingredient remove_ingredient], Recipe, user_id: user.id

    # Only a user can delete their recipe
    can :destroy, Recipe, user_id: user.id

    # Only a user can update and delete his food
    can %i[update destroy], Food, user_id: user.id
  end
end
