#encoding: utf-8
class LogoWorker 
  include Sidekiq::Worker
  def perform(name, count)
    # do something
  end
end