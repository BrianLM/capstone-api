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

  # PATCH/PUT /creatures/1
  def update
    @error = 'Invalid argument count' unless creature_params.keys.count == 1
    if !@error
      if @creature.update(creature_params)
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
