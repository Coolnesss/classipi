class ClassifyController < ApplicationController

  before_action :authenticate
  before_action :verify_params, only: [:train]
  # Use the classifier instance to train the model,
  # and save it back into the database
  def train
    return if performed?

    TrainModelJob.perform_async @current_user.id, params[:label], params[:data]

    render json: {
      success: "Training enqued"
    }, status: 200
  end

  def classify
    label = @current_user.classify params[:data]
    render json: {
      label: label
    }, status: 200
  end

  private

  def verify_params
    unless params[:data] and params[:label]
      render json: {
        message: "Failed to parse training data, did you specify the data and label attributes in your request?"
      }, status: 400
    end
  end
end
