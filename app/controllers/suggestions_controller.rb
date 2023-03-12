class SuggestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :validate_author, only: [:edit, :destroy]

    def index
      @suggestions = Suggestion.all
    end

    def show
      @suggestion = Suggestion.find(params[:id])
    end

    def new
      @topic = Topic.find(params[:topic_id])
      @suggestion = @topic.suggestions.build
    end

    def create
      @topic = Topic.find(params[:topic_id])
      @suggestion = @topic.suggestions.build(suggestion_params)
      @suggestion.author_id = current_user.id

      if @suggestion.save
        redirect_to topic_suggestion_path(@suggestion.topic, @suggestion), flash: { success: I18n.t('suggestion_create_success') }
      else
        render :new, status: :unprocessable_entity, flash: { error: I18n.t('suggestion_create_unprocessable') }
      end
    end


    def edit
      @suggestion = Suggestion.find(params[:id])
    end

    def update
      @suggestion = Suggestion.find(params[:id])

      if @suggestion.update(suggestion_params)
        redirect_to @suggestion, flash: { success: I18n.t('suggestion_update_success') }
      else
        render :edit, status: :unprocessable_entity, flash: { error: I18n.t('suggestion_update_unprocessable') }
      end
    end

    def destroy
      @suggestion = Suggestion.find(params[:id])
      @suggestion.destroy

      redirect_to topic_url(@suggestion.topic), status: :see_other, flash: { success: I18n.t('suggestion_destroy_success') }
    end

    private

    def suggestion_params
      params.require(:suggestion).permit(:title, :body)
    end

    def validate_author
      @suggestion = Suggestion.find(params[:id])
      unless @suggestion.author_id == current_user.id
        redirect_to suggestion_path, flash: { error: I18n.t('suggestion_must_be_author') }
      end
    end

end
