#encoding: utf-8
class TempWorker 
  include Sidekiq::Worker
  def perform

    logger.info { "Things are happening.2222" }
    
    # l = Logo.get_recent_gopro_picture
    # l.save
  end
end