# frozen_string_literal: true

class ExplorationsController < ProtectedController
  before_action :set_exploration, only: [:show, :update, :create]

  def show
    render json: @exploration
  end

  def create
    return head :bad_request unless @exploration.area.nil?
    return head :bad_request unless valid_area
    @exploration.area = exploration_params[:area]
    @exploration[@area_symbol] += 1
    if @exploration.save
      render json: @exploration, status: :created, location: @exploration
    else
      render json: @exploration.errors, status: :unprocessable_entity
    end
  end

  def valid_area
    @area_symbol = "top_#{exploration_params[:area][0].downcase}".to_sym
    @exploration[@area_symbol].present?
  end

  def valid_step
    exploration_params[:step].to_i <= @exploration.step.to_i
  end

  # PATCH/PUT /explorations/1
  def update
    return head :bad_request unless valid_step
    if @exploration.update(exploration_params)
      render json: @exploration
    else
      render json: @exploration.errors, status: :unprocessable_entity
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
    params.require(:exploration).permit(:user_id, :area, :step, :difficulty)
  end
end
