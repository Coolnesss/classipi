describe "User API" do
  describe "Without an existing user" do

    it "can register" do
      post '/register', params: {"email" => "great@email.com"}.to_json, headers: {'Content-Type' => 'application/json'}
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["api_key"]).to eq User.first.api_key
    end

    it "can't register with a bad email" do
      post '/register', params: {"email" => "nogood"}.to_json, headers: {'Content-Type' => 'application/json'}
      json = JSON.parse(response.body)

      expect(response).not_to be_success
      expect(json).to have_key "errors"
    end
  end
end
