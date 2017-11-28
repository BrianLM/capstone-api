# frozen_string_literal: true

class CreaturesController < ProtectedController
  before_action :set_creature, only: [:show, :update, :destroy]

  # GET /creatures/1
  def show
    render json: @creature
  end

  # POST /creatures
  def create
    if current_user.create_creature
      render json: @current_user.creature,
             status: :created, location: @current_user.creature
    else
      render json: @creature.errors, status: :unprocessable_entity
    end
  end

  def can_increase
    return false unless !current_user.encounter
    @requested = 0
    creature_params.each do |k|
      @stat = k
      @requested = creature_params[k].to_i
    end
    @requested <= current_user.user_profile.stat_points
  end

  def valid_increase
    to_check = @stat.sub('c', 'm')
    m_val = current_user.creature[to_check]
    p @stat
    p current_user.creature[:c_hp]
    p m_val >= @requested + current_user.creature[@stat]
  end

  # PATCH/PUT /creatures/1
  def update
    @error = 'Invalid argument count' unless creature_params.keys.count == 1
    @error = 'Insufficient available to increase' unless can_increase
    @error = 'Cannot exceed maximum value' unless valid_increase
    p @error
    if !@error
      # if @creature.update(creature_params)
      #   render json: @creature
      # else
      #   render json: @creature.errors, status: :unprocessable_entity
      # end
    else
      render json: @error, status: :bad_request
    end
  end

  # DELETE /creatures/1
  def destroy
    @creature.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_creature
    @creature = current_user.creature
  end

  # Only allow a trusted parameter "white list" through.
  def creature_params
    params.require(:creature).permit(:c_hp, :c_def, :c_dex, :c_spd, :c_int,
                                     :c_sig, :c_str)
  end
end
