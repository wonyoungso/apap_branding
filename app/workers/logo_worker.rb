#encoding: utf-8
class LogoWorker 
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }
  def perform

    logos = Logo.get_recent_gopro_pictures
    
    logos.each do |logo|
      if !logo.uploaded
        clnt = HTTPClient.new

        File.open("#{Rails.root.to_s}/#{logo.picture.path(:filtered).gsub('./', '')}") do |file|
          body = { 'logo[picture]' => file }
          res = clnt.post('http://staging.apap.or.kr/api/logos.json', body)
        end

        logo.uploaded = true
        logo.save
      end
    end
  end
end