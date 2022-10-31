class ProfileController < ApplicationController
  before_action :set_user
  before_action :auth_edit!, :if => !:is_own?, except: [:index, :show]

  def show

  end

  def edit
    
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Topic.new(profile_params)

    if not @profile.avatar_seed
        @profile.avatar_seed = rand(9999)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def auth_edit!
    if @user != current_user
      redirect_to profile_path, flash: { error: I18n.t("profile_edit_unauthorized") }
    end
  end

  def reroll_avatar
    @user.profile.avatar_seed = rand(9999)
    @user.profile.save
    redirect_to profile_path, flash: { success: I18n.t("profile_avatar_rerolled") }
  end

end
