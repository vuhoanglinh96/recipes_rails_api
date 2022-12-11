module Apu
  class UserRatingsController < Api::BaseController
    # jitera-anchor-dont-touch: before_action_filter
    before_action :doorkeeper_authorize!, only: %w[create]
    before_action :current_user_authenticate, only: %w[create]

    # jitera-anchor-dont-touch: actions

    def create
      request = {}
      request.merge!('recipe_id' => params.dig(:user_rating, :recipe_id))
      request.merge!('star' => params.dig(:user_rating, :star))

      @user_rating = UserRating.find_or_create_by(user: current_user, recipe_id: request['recipe_id'])
      @user_rating.star = request['star']
      @error_object = @user_rating.errors.messages unless @user_rating.save
    end
  end
end
