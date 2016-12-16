class TrainModelWorker
  include Sidekiq::Worker

  def perform(user_id, label, data)
    User.find(user_id).train label, data
  end
end
