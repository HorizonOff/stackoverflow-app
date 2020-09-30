class ContentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_content, only: %i[show edit update]

  def index
    if params[:tag]
      @content = Content.joins(:tags).where(tags: { name: params[:tag] })
    else
      @content = Content.includes(:tags, question: :user).all
    end
  end

  def show
    @content.increment_views
    @answer = @content.answers.build
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    if @content.save && @content.persisted?
      @question = @content.build_question(body: params[:content][:question][:body],
                                          user: current_user).save
      find_or_create_tag(params[:content][:tags], @content)

      flash[:success] = 'Content was successfully created'
      redirect_to question_path(@content)
    else
      render :new
    end
  end

  def update
    if @content.update(content_params)
      @content.question.update(body: params[:content][:message][:body])
      find_or_create_tag(params[:content][:tags], @content)

      flash[:success] = 'Content was successfully updated'
      redirect_to question_path(@content)
    else
      render :edit
    end
  end

  private

  def set_content
    @content ||= Content.find_by_id(params[:id])
  end

  def find_or_create_tag(tags_string, content)
    return unless tags_string

    old_tags = content.tags.map(&:name)
    new_tags = tags_string.first.split(',')

    (new_tags - old_tags).each do |tag_name|
      content.tags << Tag.find_or_create_by!(name: tag_name)
    end
  end

  def content_params
    params.require(:content).permit(:title)
  end
end
