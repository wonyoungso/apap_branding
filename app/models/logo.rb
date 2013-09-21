class Logo < ActiveRecord::Base

  has_attached_file :picture, 
                    :styles => {
                      :thumb => "100x100#",
                      :filtered => { :processors => [:brightness] }
                    },
                    :path => "./public/system/#{Rails.env.to_s}/logos/pictures/:id/:style/:filename",
                    :url => "/system/#{Rails.env.to_s}/logos/pictures/:id/:style/:filename"
  
  after_create :push_to_real_server, :delete_if_month_full

  def self.get_recent_gopro_picture
    l = Logo.new

    # 이후 고프로에서 땡겨오는 부분이 여기 들어 감! 땡겨오고 바로 지움. 
    test_file = Rails.root.join('spec', 'fixtures', 'logo.jpg')
    l.picture = Rack::Test::UploadedFile.new(test_file, "image/jpg")

    return l
  end

  def push_to_real_server
    
  end

  def delete_if_month_full
  end
end
