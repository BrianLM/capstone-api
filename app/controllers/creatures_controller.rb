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
    m_val >= @requested + current_user.creature[@stat]
  end

  def can_evolve
    @creature.c_hp == @creature.m_hp &&
      @creature.c_dex == @creature.m_dex &&
      @creature.c_def == @creature.m_def &&
      @creature.c_sig == @creature.m_sig &&
      @creature.c_spd == @creature.m_spd &&
      @creature.c_str == @creature.m_str &&
      @creature.c_int == @creature.m_int
  end

  def do_evolve
    @error = 'Cannot evolve at this time' unless can_evolve
    @creature.m_hp *= 1.2
    @creature.m_def *= 1.2
    @creature.m_dex *= 1.2
    @creature.m_spd *= 1.2
    @creature.m_int *= 1.2
    @creature.m_sig *= 1.2
    @creature.m_str *= 1.2
    @creature.c_hp *= 0.8
    @creature.c_def *= 0.8
    @creature.c_dex *= 0.8
    @creature.c_spd *= 0.8
    @creature.c_int *= 0.8
    @creature.c_sig *= 0.8
    @creature.c_str *= 0.8
  end

  def do_increase
    p 'In do_increase'
    @creature[@stat] += creature_params[@stat]
    p @creature[@stat]
    diff = current_user.user_profile.stat_points - @requested
    current_user.user_profile.update(stat_points: diff)
  end

  # PATCH/PUT /creatures/1
  def update
    if params.key? :evolve
      do_evolve
    else
      @error = 'Invalid argument count' unless creature_params.keys.count == 1
      @error = 'Insufficient available to increase' unless can_increase
      @error = 'Cannot exceed maximum value' unless valid_increase
      do_increase unless @error
    end
    if !@error
      if @creature.save
        render json: @creature
      else
        render json: @creature.errors, status: :unprocessable_entity
      end
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
