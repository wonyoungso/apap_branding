#encoding: utf-8
require "spec_helper"

describe "로고 워커" do
  it "로고 워커가 실행되면, 사진을 한 장 로컬에 등록하여야 한다." do
    LogoWorker.perform_async
    LogoWorker.jobs.size.should == 1

    logo_worker = LogoWorker.new
    logo_worker.perform
    Logo.count.should == 1
  end

  
end