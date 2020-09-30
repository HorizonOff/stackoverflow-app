class Api::V1::ContentsController < ActionController::Base
  protect_from_forgery with: :null_session

  def index
    @contents = Content.includes(:tags, question: :user).all
  end

  def show
    @content = Content.find_by_id(params[:id])
  end
end
