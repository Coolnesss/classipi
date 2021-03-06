class User < ApplicationRecord
  # Assign an API key on create
   before_create do |user|
     user.api_key = user.generate_api_key
   end

   validates :email, uniqueness: true, email: true, presence: true
   serialize :model, String

   # Initialize a Bayes classifier instance for each new user
   after_create do |user|
     user.model = Marshal.dump ClassifierReborn::Bayes.new(auto_categorize: true)
     save
   end

   def load_model
     Marshal.load self.model
   end

   def train(label, data)
    trained_model = load_model
    ret = trained_model.train label, data
    self.model = Marshal.dump trained_model
    save
    ret
   end

   def classify(data)
     trained_model = load_model
     trained_model.classify data
   end

   # Generate a unique API key
   def generate_api_key
     loop do
       token = SecureRandom.base64.tr('+/=', 'Qrt')
       break token unless User.exists?(api_key: token)
     end
   end
end
