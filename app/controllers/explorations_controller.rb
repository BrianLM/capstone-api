class ExplorationsController < ApplicationController
  before_action :set_exploration, only: [:show, :update, :destroy]

  # GET /explorations
  def index
    @explorations = Exploration.all

    render json: @explorations
  end

  # GET /explorations/1
  def show
    render json: @exploration
  end

  # POST /explorations
  def create
    @exploration = Exploration.new(exploration_params)

    if @exploration.save
      render json: @exploration, status: :created, location: @exploration
    else
      render json: @exploration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /explorations/1
  def update
    if @exploration.update(exploration_params)
      render json: @exploration
    else
      render json: @exploration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /explorations/1
  def destroy
    @exploration.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exploration
      @exploration = Exploration.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def exploration_params
      params.require(:exploration).permit(:user_id, :current, :top_f, :top_m, :top_p, :top_d)
    end
end
