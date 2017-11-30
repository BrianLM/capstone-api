# frozen_string_literal: true

class ExplorationsController < ProtectedController
  before_action :set_exploration, only: [:show, :update, :create]

  def show
    render json: @exploration
  end

  def create
    if current_user.create_exploration
      render json: current_user.exploration,
             status: :created,
             location: current_user.exploration
    else
      render json: current_user.exploration.errors,
             status: :unprocessable_entity
    end
  end

  def engery_available
     return @current_user_profile.energy unless !@current_user_profile.els.nil?
     returned = ((DateTime.now.utc - @current_user_profile.els).to_i / 180) / 3
     if returned.positive?
       max_e = Level.find_by(level: @current_user_profile.level).energy
       if @current_user_profile.energy + returned > max_e
         @current_user_profile.energy = max_e
         @current_user_profile.els = nil
       else
         @current_user_profile.energy += returned
         @current_user_profile.els = DateTime.now.utc
       end
     end
     @current_user_profile.energy
  end

  def spend_energy
    needed = (@dif / 10) + 1
    raise unless engery_available >= needed
    @current_user_profile.energy -= needed
    @current_user_profile.els = DateTime.now.utc if @current_user_profile.els.nil?
    @current_user_profile.save
  rescue
    @errors = 'Insufficient energy'
  end

  def do_step
    raise unless !current_user.exploration.encounter
    @dif = current_user.exploration.dif
    spend_energy
    @exploration.step += 1
    @boss = @exploration.step == @exploration.end
    encounter if @boss || check_encounter
  rescue
    @errors = 'Move action not valid at this time'
  end

  def valid_start
    @exploration[@area_symbol].present? &&
      @exploration.area.nil? &&
      exploration_params[:dif].present? &&
      exploration_params[:dif] <= @exploration[@area_symbol]
  end

  def do_start
    @area_symbol = "top_#{exploration_params[:area][0].downcase}".to_sym
    raise unless valid_start
    @dif = exploration_params[:dif]
    spend_energy
    @exploration.area = exploration_params[:area]
    @exploration[@area_symbol] += 1 if @dif == @exploration[@area_symbol]
    @exploration.dif = exploration_params[:dif]
    @exploration.step = 1
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
    crit = first.c_int > rand(100)
    hit = first.c_sig - second.c_dex + 80 > rand(100) || crit
    damage = (first.c_str * 2) - second.c_def if hit
    c_hp = second.c_hp
    second.c_hp -= damage if damage
    if second.class.name == 'Creature'
      if second.c_hp.negative?
        second.damage += c_hp
      else
        second.damage += damage
      end
    end
    second.save
  end

  def do_attack
    @encounter = current_user.encounter
    raise unless !@encounter.nil?
    @dif = current_user.exploration.dif
    spend_energy
    @user_creature = current_user.creature
    if u_speed > e_speed
      deal_damage @user_creature, @encounter
      deal_damage @encounter, @user_creature if @encounter.c_hp.positive?
    else
      deal_damage @encounter, @user_creature
      deal_damage @user_creature, @encounter if @user_creature.c_hp.positive?
    end
    resolve_encounter if !@user_creature.c_hp.positive? || !@encounter.c_hp.positive?
  rescue
    @errors = 'Nothing to attack'
  end

  def resolve_encounter
    @encounter.destroy
    restore = @user_creature.c_hp + @user_creature.damage
    @user_creature.update(c_hp: restore, damage: 0)
    resolve_exploration if @exploration.step == @exploration.end &&
                           @user_creature.c_hp.positive?
    @current_user_profile.save
  end

  def resolve_exploration
    evaluate_drops
    grant_xp
    @exploration.area = nil
    @exploration.step = nil
    @exploration.end = nil
    @exploration.dif = nil
  end

  def evaluate_drops
    @exploration.dif = 1 unless @exploration.dif.positive?
    @current_user_profile.gold += @exploration.dif * rand(@exploration.dif..100)
    random_generator if rand(1..100) > 95
  end

  def grant_xp
    @current_user_profile.experience += @exploration.dif
    to_level = Level.find_by(level: @current_user_profile.level).required
    if to_level == @current_user_profile.experience
      level_up = Level.find_by(level: @current_user_profile.level)
      @current_user_profile.level += 1
      @current_user_profile.energy = level_up.energy
      @current_user_profile.experience = 0
      @current_user_profile.stat_points += 1
    end
  end

  def random_generator
    case rand(1..100)
    when 1..23
      grant_item 'stones'
    when 24..46
      grant_item 'ore'
    when 47..69
      grant_item 'lumber'
    when 70..92
      grant_item 'grains'
    when 93..94
      grant_item 'arms'
    when 95..96
      grant_item 'legs'
    when 97..98
      grant_item 'head'
    when 99..100
      grant_item 'tail'
    end
  end

  def grant_item(name)
    found = current_user.items.find_by(name: name)
    item = found || Item.new
    if found
      item.quantity += 1
    else
      item.user = current_user
      item.name = name
      item.quantity = 1
    end
    item.save
  end

  # PATCH/PUT /explorations/1
  def update
    do_step if params.key? :move
    do_start if !@errors.present? && (params.key? :start)
    do_attack if !@errors.present? && (params.key? :attack)
    if !@errors
      if @exploration.save
        render json: @exploration
      else
        render json: @errors, status: :unprocessable_entity
      end
    else
      render json: @errors, status: :bad_request
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exploration
    @exploration = current_user.exploration
    @current_user_profile = current_user.user_profile
  end

  # Only allow a trusted parameter "white list" through.
  def exploration_params
    params.require(:exploration).permit(:user_id, :area, :step, :dif)
  end
end
