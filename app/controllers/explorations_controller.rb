# frozen_string_literal: true

class ExplorationsController < ProtectedController
  before_action :set_exploration, only: [:show, :update, :create]

  def show
    render json: @exploration
  end

  def create
    if current_user.create_exploration
      render json: current_user.create_exploration,
             status: :created,
             location: current_user.create_exploration
    else
      render json: current_user.create_exploration.errors,
             status: :unprocessable_entity
    end
  end

  def do_step
    raise unless !current_user.exploration.encounter
    needed = (current_user.exploration.dif / 10) + 1
    @exploration.step += 1 if current_user.user_profile.energy >= needed
    @boss = @exploration.step == @exploration.end
    encounter if @boss
  rescue
    @errors = 'Cannot move in encounter'
  end

  def do_start
    @area_symbol = "top_#{exploration_params[:area][0].downcase}".to_sym
    raise unless @exploration[@area_symbol].present? &&
                 @exploration.area.nil? &&
                 exploration_params[:dif].present?
    @exploration.area = exploration_params[:area]
    @exploration[@area_symbol] += 1
    @exploration.dif = exploration_params[:dif]
    @exploration.step = 0
    @exploration.end = (exploration_params[:dif] / 10) + 5
  rescue
    @errors = 'Invalid area argument'
  end

  def check_encounter
    modifier = @exploration.dif * @exploration.step
    rand(100) + modifier >= 95
  end

  def encounter
    enc = Encounter.new
    enc.user = current_user
    enc.exploration = @exploration
    modifier = (@exploration.dif / 10).positive? ? @exploration.dif / 10 : 1
    modifier *= 1.5 if @boss
    enc.attributes.each_key do |key|
      enc[key] *= modifier if key.start_with? 'c_'
    end
  end

  def u_speed
    @user_creature.c_spd
  end

  def e_speed
    @encounter.c_spd
  end

  def deal_damage(first, second)

  end

  def do_attack
    @user_creature = current_user.creature
    @encounter = current_user.encounter
    if u_speed > e_speed
      deal_damage @user_creature, @encounter
    else
      deal_damage @encounter, @user_creature
    end
  end

  # PATCH/PUT /explorations/1
  def update
    do_step if params.key? :move
    do_start if params.key? :start
    do_attack if params.key? :attack
    encounter if check_encounter
    if @exploration.save && !@errors
      render json: @exploration
    else
      render json: @errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exploration
    @exploration = current_user.exploration
    # @exploration = current_user.explorations.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def exploration_params
    params.require(:exploration).permit(:user_id, :area, :step, :dif)
  end
end
