class Api::RecipesController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[index show update destroy]
  before_action :current_user_authenticate, only: %w[index show update destroy]
  before_action :init_request_param, only: :index

  # jitera-anchor-dont-touch: actions
  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @error_message = true unless @recipe&.destroy
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])

    request = {}
    request.merge!('title' => params.dig(:recipes, :title))
    request.merge!('descriptions' => params.dig(:recipes, :descriptions))
    request.merge!('time' => params.dig(:recipes, :time))
    request.merge!('difficulty' => params.dig(:recipes, :difficulty))
    request.merge!('category_id' => params.dig(:recipes, :category_id))
    request.merge!('user_id' => params.dig(:recipes, :user_id))

    @error_object = @recipe.errors.messages unless @recipe.update(request)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @error_message = true if @recipe.blank?
  end

  def create
    @recipe = Recipe.new

    request = {}
    request.merge!('title' => params.dig(:recipes, :title))
    request.merge!('descriptions' => params.dig(:recipes, :descriptions))
    request.merge!('time' => params.dig(:recipes, :time))
    request.merge!('difficulty' => params.dig(:recipes, :difficulty))
    request.merge!('category_id' => params.dig(:recipes, :category_id))
    request.merge!('user_id' => params.dig(:recipes, :user_id))

    @recipe.assign_attributes(request)
    @error_object = @recipe.errors.messages unless @recipe.save
  end

  def index
    start_time, end_time = convert_time_to_start_time_and_end_time(request['time'])
    @recipes = Recipe.search_by_title(request['title']).search_by_start_time(start_time).search_by_end_time(end_time).search_by_difficulty(request['difficulty'])
  end

  private

  def init_request_param
    @request = {}

    @request.merge!('title' => params.dig(:recipes, :title))
    @request.merge!('descriptions' => params.dig(:recipes, :descriptions))
    @request.merge!('time' => params.dig(:recipes, :time))
    @request.merge!('difficulty' => params.dig(:recipes, :difficulty))
    @request.merge!('category_id' => params.dig(:recipes, :category_id))
    @request.merge!('user_id' => params.dig(:recipes, :user_id))
    @request.merge!('convert_unit' => params.dig(:recipes, :convert_unit))
  end

  def convert_time_to_start_time_and_end_time(time_param)
    return nil if time_param.blank?

    time_arr = time_param.split(' - ')
    time_arr.map do |timee|
      QuantityConverter.new(timee).time_converter
    end
  end
end
