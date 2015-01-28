class PatchesController < ApplicationController

  # show all patches
  def index
    render json: Patch.all
  end

  # create a new patch
  def create
    patch = Patch.new(patch_params)
    if patch.save
      render json: patch, except: [:created_at, :updated_at]
    else
      render json: patch.errors, status: :unprocessable_entity
    end
  end

  # GET /player/:id/patches
  # show patches for player
  def show
    patches = Player.find(params[:id]).patches
    render json: patches, except: [:created_at, :updated_at]
  end

  private
    def patch_params
      params.permit(:player_id, :name)
    end
end