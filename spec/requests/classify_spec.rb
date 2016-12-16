describe "Classify API" do
  describe "Without an existing model" do

    before :each do
      FactoryGirl.create :user
    end

    it 'Allows training a model' do
      training_data = {
        "data" => "highly interesting",
        "label" => "Interesting"
      }

      expect(User.first.load_model.categories).to be_empty

      post '/train', params: training_data.to_json , headers: {
        "Authorization" => "Token token=#{User.first.api_key}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json).to have_key "success"

      # Make sure the job was enqueued
      assert_equal 1, TrainModelWorker.jobs.size

      # Make sure it was executed
      TrainModelWorker.drain
      expect(User.first.load_model.categories).to include "Interesting"

    end

  end
  describe "With an existing model" do

    before :each do
      FactoryGirl.create :trained_user
    end

    it 'Allows classifying data' do
      data_to_classify = {
        "data" => "great stuff guys"
      }
      post '/classify', params: data_to_classify.to_json , headers: {
        "Authorization" => "Token token=#{User.first.api_key}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json).to have_key "label"
    end

  end

end
