# frozen_string_literal: true

class UserProfilesController < ProtectedController
  before_action :set_user_profile, only: [:show, :update, :destroy]

  # No use case to index user profiles.
  # GET /user_profiles
  # def index
  #   @user_profiles = UserProfile.all
  #
  #   render json: @user_profiles
  # end

  # GET /user_profiles/1
  def show
    render json: @user_profile
  end

  # POST /user_profiles
  def create
    @user_profile = UserProfile.new(user_profile_params)

    if @user_profile.save
      render json: @user_profile, status: :created, location: @user_profile
    else
      render json: @user_profile.errors, status: :unprocessable_entity
    end
  end

  # No use case to update, other actions should apply the changes
  # PATCH/PUT /user_profiles/1
  # def update
  #   if @user_profile.update(user_profile_params)
  #     render json: @user_profile
  #   else
  #     render json: @user_profile.errors, status: :unprocessable_entity
  #   end
  # end

  # No use case to delete.
  # DELETE /user_profiles/1
  # def destroy
  #   @user_profile.destroy
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile
    @user_profile = UserProfile.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_profile_params
    params.require(:user_profile).permit(:user_id, :experience, :level, :gold)
  end
end
