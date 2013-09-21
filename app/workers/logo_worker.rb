#encoding: utf-8
class LogoWorker 
  include Sidekiq::Worker

  def perform

    l = Logo.get_recent_gopro_picture
    l.save
  end
end