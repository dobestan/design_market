class RequestsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def new
    @request = Request.new
    @types = Type.all.map { |type| [type.name, type.id]}
  end

  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    if @request.save
      flash[:success] = "의뢰가 정상적으로 등록되었습니다."
      redirect_to current_user
    else
      render 'new'
    end
  end

  def show
    @request = Request.find_by(token: params[:token])
  end

  private
    def request_params
      params.require(:request).permit(:usage, :design_type, :description)
    end
end
