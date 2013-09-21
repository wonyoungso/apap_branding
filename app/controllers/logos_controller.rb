#encoding: utf-8
class LogosController < ApplicationController
  def index
    @page = params[:page].present? ? params[:page] : 1
    @logos = Logo.order('pictured_at DESC').paginate(:page => @page, :per_page => 20)
  end

  def new
    LogoWorker.perform_async
    
    redirect_to logos_path, :notice => '성공적으로 등록하였습니다.'
  end

  def create
    @logo = Logo.new(params[:logo])
    @logo.pictured_at = DateTime.now unless params[:logo][:pictured_at].present?
    
    if @logo.save
      redirect_to logos_path, :notice => '성공적으로 등록하였습니다.'
    else
      redirect_to resquest.referer, :alert => '저장 중 오류가 발생하였습니다.'
    end
  end

  def edit
    @logo = Logo.find params[:id]
  end

  def update
    @logo = Logo.find params[:id]
    #sif @logo.update_attributes(params[:logo])

  end

  def destroy
    @logo = Logo.find params[:id]
    @logo.destroy

    redirect_to logos_path, :notice => '성공적으로 삭제하였습니다.'
  end

end
