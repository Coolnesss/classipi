class TrainModelJob
  include SuckerPunch::Job

  def perform(user_id, label, data)
    ActiveRecord::Base.connection_pool.with_connection do
      user = User.find(user_id)
      user.train label, data
    end
  end
end
