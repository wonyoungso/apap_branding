class Logo < ActiveRecord::Base

  has_attached_file :picture, 
                    :styles => {
                      :thumb => "100x100#",
                      :filtered => { :processors => [:crop_rotate, :brightness] },
                      :multiplied => { :processors => [:crop_rotate, :multiply] }
                    },
                    :path => "./public/system/#{Rails.env.to_s}/logos/pictures/:id/:style/:filename",
                    :url => "/system/#{Rails.env.to_s}/logos/pictures/:id/:style/:filename"
  

  def self.get_recent_pictures
    
    # # 이후 고프로에서 땡겨오는 부분이 여기 들어 감! 땡겨오고 바로 지움. 
    # test_file = Rails.root.join('spec', 'fixtures', 'logo.jpg')
    # l.picture = Rack::Test::UploadedFile.new(test_file, "image/jpg")
    logos = []

    files = Dir.glob(File.join("/home/deployer/snapshots", "*"))
    files.each do |file|
      l = Logo.new
      l.pictured_at = Time.at(file.split("/").last.split(".")[0].to_i/1000).to_datetime
      l.picture = Rack::Test::UploadedFile.new(file, "image/jpg")

      if l.save
        logos << l 
        File.delete(file)
      end
    end

    return logos
  end
end
