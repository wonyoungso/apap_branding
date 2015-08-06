#encoding: utf-8
class LogoWorker 
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(10) }
  def perform

    @website_url ||= YAML.load(ERB.new(File.read("#{Rails.root}/config/host.yml")).result)[Rails.env]["url"]   

    logos = Logo.get_recent_pictures
    
    logos.each do |logo|
      if !logo.uploaded
        clnt = HTTPClient.new
        clnt.receive_timeout = 1000000

        body = {} 


        res = clnt.post("https://apap.or.kr/api/logos.json", {
          'logo[picture]' => File.open("#{Rails.root.to_s}/#{logo.picture.path(:filtered).gsub('./', '')}"),
          'logo[multiplied_picture]' => File.open("#{Rails.root.to_s}/#{logo.picture.path(:multiplied).gsub('./', '')}"),
          'logo[pictured_at]' => logo.pictured_at
        })

        
        logo.uploaded = true
        logo.save
      end
    end
  end
end