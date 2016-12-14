describe "Classify API" do
  describe "Without an existing model" do

    before :each do
      FactoryGirl.create :user
    end

    it 'Allows training a model' do
      training_data = {
        "data" => "highly interesting",
        "label" => "interesting"
      }
      post '/train', params: training_data.to_json , headers: {
        "Authorization" => "Token token=#{User.first.api_key}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json).to have_key "success"
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
