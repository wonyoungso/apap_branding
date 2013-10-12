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
      tt = file.split("_")[1].split('-').join('')
      l.pictured_at = DateTime.new(tt[0..3].to_i, tt[4..5].to_i, tt[6..7].to_i, tt[8..9].to_i, tt[10..11].to_i, tt[12..13].to_i)
      
      l.picture = Rack::Test::UploadedFile.new(file, "image/jpg")

      if l.save
        logos << l 
        #File.delete(file)
      end
    end

    return logos
  end
end
