class TopicsController < ApplicationController
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

    if @topic.save
      redirect_to @topic
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update(topic_params)
      redirect_to @topic
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    redirect_to topics_path, status: :see_other
  end

  private
    def topic_params
      params.require(:topic).permit(:title, :body)
    end
end
