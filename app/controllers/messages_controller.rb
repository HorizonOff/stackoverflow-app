class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_answer, only: %i[edit update vote]

  def create
    @answer = Message.new(message_params)
    @answer.user = current_user
    @answer.content_id = params[:question_id]
    if @answer.save
      flash[:success] = 'Answer was successfully created'
      redirect_to question_path(@answer.content)
    else
      render :new
    end
  end

  def update
    if @answer.update(message_params)
      flash[:success] = 'Answer was successfully updated'
      redirect_to question_path(@answer.content)
    else
      render :edit
    end
  end

  def vote
    vote = Vote.find_or_initialize_by(message_id: params[:id], user: current_user)
    return render json: { error: 'You already vote' } if vote.persisted? && vote.up.to_s == params[:up]
    vote.up = params[:up]
    if vote.save
      @answer.increment! :vote_score if vote.up
      @answer.decrement! :vote_score unless vote.up

      render json: { vote_score: @answer.vote_score }
    end
  end

  private

  def set_answer
    @answer = Message.find_by_id(params[:id])
  end

  def message_params
    params.require(:message).permit(:body, :answer)
  end
end
