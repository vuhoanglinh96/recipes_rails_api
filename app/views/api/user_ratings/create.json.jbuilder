if @error_object.blank?
  json.user_rating do
    json.id @user_rating.id
    json.created_at @user_rating.created_at
    json.updated_at @user_rating.updated_at
    json.user_id @user_rating.user_id
    json.recipe_id @user_rating.recipe_id
    json.star @user_rating.star
  end
else
  json.error_object @error_object
end
