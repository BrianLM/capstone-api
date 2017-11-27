class CreaturesController < ApplicationController
  before_action :set_creature, only: [:show, :update, :destroy]

  # GET /creatures
  def index
    @creatures = Creature.all

    render json: @creatures
  end

  # GET /creatures/1
  def show
    render json: @creature
  end

  # POST /creatures
  def create
    @creature = Creature.new(creature_params)

    if @creature.save
      render json: @creature, status: :created, location: @creature
    else
      render json: @creature.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /creatures/1
  def update
    if @creature.update(creature_params)
      render json: @creature
    else
      render json: @creature.errors, status: :unprocessable_entity
    end
  end

  # DELETE /creatures/1
  def destroy
    @creature.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creature
      @creature = Creature.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def creature_params
      params.require(:creature).permit(:user_id, :c_hp, :c_def, :c_dex, :c_spd, :c_int, :c_sig, :c_str, :m_hp, :m_def, :m_dex, :m_spd, :m_int, :m_sig, :m_str)
    end
end