class ProfileController < ApplicationController
  before_action :set_user
  before_action :auth_edit!, :if => !:is_own?, except: [:index, :show]

  def show

  end

  def edit
    
  end

  def set_user
    @user = User.find(params[:id])
  end

  def auth_edit!
    if @user != current_user
      redirect_to profile_path, flash: { error: I18n.t("profile_edit_unauthorized") }
    end
  end
end
