require 'rails_helper'
RSpec.describe TrainModelJob, type: :job do

  before :each do
    FactoryGirl.create :user
  end

  it "Trains the model correctly" do
    expect(User.first.load_model.categories).to be_empty
    TrainModelJob.perform_async User.first.id, "Interesting", "Interesting stuff really"
    expect(User.first.load_model.categories).to include "Interesting"
  end

end
