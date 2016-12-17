describe "Classify API" do
  describe "Without an existing model" do

    def make_request(endpoint, api_key, data)
      post endpoint, params: data.to_json , headers: {
        "Authorization" => "Token token=#{api_key}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    before :each do
      FactoryGirl.create :user
    end

    it 'Allows training a model' do
      training_data = {
        "data" => "highly interesting",
        "label" => "Interesting"
      }

      expect(User.first.load_model.categories).to be_empty
      make_request('/train', User.first.api_key, training_data)

      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json).to have_key "success"

      # Make sure the job was executed
      expect(User.first.load_model.categories).to include "Interesting"
    end

    it "returns unauthorized with an invalid API key" do
      make_request('/train', "qwerty", {})

      expect(response).to be_unauthorized
    end

    it "returns bad request with no label" do
      make_request('/train', User.first.api_key, {data: "legit data"})

      expect(response).to be_bad_request
    end

    it "returns bad request with no data" do
      make_request('/train', User.first.api_key, {label: "good"})

      expect(response).to be_bad_request
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
