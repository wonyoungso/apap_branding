#encoding: utf-8
require "spec_helper"

describe "로고 모델" do
  it "고프로에 저장된 사진을 한 장 가져올 수 있어야 한다(임시 테스트)" do
    logo = Logo.get_recent_gopro_picture
    logo.save

    logo.picture.present?.should == true
    logo.picture_file_size.should > 0 
  end

  it "저장이 되면, 자동으로 실서버에 푸시되어야 한다" do 
    logo = Logo.get_recent_gopro_picture
    logo.save

    
  end

  it "실서버에 한달 이상의 분량이 있으면, 가장 맨 나중 껏부터 삭제되어야 한다" do
  end
end