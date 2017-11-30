# frozen_string_literal: true

class UserProfilesController < ProtectedController
  before_action :set_user_profile, only: [:show, :update, :destroy]

  def check_energy
    last_spent = @user_profile.els
    time_diff =  (DateTime.now.utc - last_spent).to_i
    recovery = (time_diff / 180) / 3
    if recovery > @max_energy || recovery == max_energy
      @user_profile.update(energy: @max_energy, els: nil)
    else
      new_energy = recovery + @user_profile.energy
      new_els = last_spent + (recovery * 180)
      @user_profile.update(energy: new_energy, els: new_els)
    end
  end

  # GET /user_profiles/1
  def show
    @max_energy = Level.find_by(level: @user_profile.level).energy
    @user_profile.update(els: nil) if @max_energy == @user_profile.energy
    check_energy unless @user_profile.els.nil?
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile
    @user_profile = current_user.user_profile
  end

  # Only allow a trusted parameter "white list" through.
  def user_profile_params
    params.require(:user_profile).permit(:user_id, :experience, :level, :gold)
  end
end
