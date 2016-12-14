class UsersController < ApplicationController
  def register
    user = User.new email: params[:email]
    if user.save
      render json: {
        api_key: user.api_key,
        note: "Your registration is complete. Be sure to save the API key, you won't get it back later."
      }, status: 200
    else
      render json: {
        failed: "Your registration failed",
        errors: user.errors.full_messages
      }, status: 400
    end
  end
end
