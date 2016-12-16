require 'rails_helper'
RSpec.describe TrainModelWorker, type: :worker do

  before :each do
    FactoryGirl.create :user
  end

  it "Trains the model correctly" do
    TrainModelWorker.perform_async User.first.id, "Interesting", "Interesting stuff really"
    expect(User.first.load_model.categories).to be_empty
    
    TrainModelWorker.drain
    expect(User.first.load_model.categories).to include "Interesting"
  end

end
