class HardWorker
  def sidekiq_logger
    @@sidekiq_logger ||= Logger.new("#{Rails.root}/log/sidekiq.log")
  end


  include Sidekiq::Worker

  def perform(name, count)
    sidekiq_logger.debug "NOW Doing some hard work"
  end
end