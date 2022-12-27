# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :validate_author, only: [:edit, :destroy]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.author_id = current_user.id

    if @topic.save
      redirect_to @topic, flash: { success: I18n.t('topic_create_success') }
    else
      render :new, status: :unprocessable_entity, flash: { error: I18n.t('topic_create_unprocessable') }
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update(topic_params)
      redirect_to @topic, flash: { success: I18n.t('topic_update_success') }
    else
      render :edit, status: :unprocessable_entity, flash: { error: I18n.t('topic_update_unprocessable') }
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    redirect_to topics_path, status: :see_other, flash: { success: I18n.t('topic_destroy_success') }
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end

  def validate_author
    @topic = Topic.find(params[:id])
    unless @topic.author_id == current_user.id
      redirect_to topic_path, flash: { error: I18n.t('topic_must_be_author') }
    end
  end
end
