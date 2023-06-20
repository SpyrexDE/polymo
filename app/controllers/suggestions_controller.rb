class SuggestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :validate_author, only: [:edit, :destroy]

    def index
      @suggestions = Suggestion.all
    end

    def show
      @topic = Topic.find(params[:topic_id])
      @suggestion = @topic.suggestions.find_by(topic_id: params[:topic_id], relative_id: params[:relative_id])
    end

    def new
      @topic = Topic.find(params[:topic_id])
      @suggestion = @topic.suggestions.build
    end

    def create
      @topic = Topic.find(params[:topic_id])

      last_suggestion = @topic.suggestions.order(:relative_id).last
      new_relative_id = last_suggestion ? last_suggestion.relative_id + 1 : 1

      @suggestion = @topic.suggestions.new(suggestion_params.merge(relative_id: new_relative_id))
      @suggestion.author_id = current_user.id

      if @suggestion.save
        redirect_to topic_suggestion_path(@suggestion.topic, @suggestion.relative_id), flash: { success: I18n.t('suggestion_create_success') }
      else
        render :new, status: :unprocessable_entity, flash: { error: I18n.t('suggestion_create_unprocessable') }
      end
    end


    def edit
      @topic = Topic.find(params[:topic_id])
      @suggestion = @topic.suggestions.find_by(topic_id: params[:topic_id], relative_id: params[:relative_id])
    end

    def update
      @topic = Topic.find(params[:topic_id])
      @suggestion = @topic.suggestions.find_by(topic_id: params[:topic_id], relative_id: params[:relative_id])

      if @suggestion.update(suggestion_params)
        redirect_to topic_suggestion_path(@suggestion.topic, @suggestion.relative_id), flash: { success: I18n.t('suggestion_update_success') }
      else
        render :edit, status: :unprocessable_entity, flash: { error: I18n.t('suggestion_update_unprocessable') }
      end
    end

    def destroy
      @topic = Topic.find(params[:topic_id])
      @suggestion = @topic.suggestions.find_by(topic_id: params[:topic_id], relative_id: params[:relative_id])
      @suggestion.destroy

      redirect_to topic_url(@suggestion.topic), status: :see_other, flash: { success: I18n.t('suggestion_destroy_success') }
    end

    private

    def suggestion_params
      params.require(:suggestion).permit(:title, :body)
    end

    def validate_author
      @topic = Topic.find(params[:topic_id])
      @suggestion = @topic.suggestions.find_by(topic_id: params[:topic_id], relative_id: params[:relative_id])

      unless @suggestion.author_id == current_user.id
        redirect_to suggestion_path, flash: { error: I18n.t('suggestion_must_be_author') }
      end
    end

end
