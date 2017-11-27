# frozen_string_literal: true

class ExplorationsController < ProtectedController
  # before_action :set_exploration, only: [:show, :update, :destroy]

  # PATCH/PUT /explorations/1
  def update
    current_user.exploration.current = exploration_params[:current]
    current_user.exploration.save
    # if @exploration.update(exploration_params)
    #   render json: @exploration
    # else
    #   render json: @exploration.errors, status: :unprocessable_entity
    # end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exploration
    @exploration = current_user.explorations.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def exploration_params
    params.require(:exploration).permit(:user_id, :current)
  end
end
