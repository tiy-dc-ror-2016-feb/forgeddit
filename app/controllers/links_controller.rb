class LinksController < ApplicationController
  def index
    params[:per_page] = (params[:per_page] || 10).to_i
    params[:page] = (params[:page] || 1).to_i
    offset = params[:per_page] * params[:page] - params[:per_page]

    @links = Link.offset(offset).limit(params[:per_page])
  end

  def new
    @link = Link.new
  end

  def show
    @link = Link.find(params[:id])
  end

  def edit
    @link = Link.find(params[:id])
  end

  def destroy
    @link = Link.find(params[:id]).destroy
    redirect_to links_path
  end

  def update
    @link = Link.find(params[:id])
    @link.update(link_params)
    redirect_to action: "show", id: @link.id
  end

  def create
    @link = current_user.links.create(link_params)
    redirect_to individual_links_index_path
  end

  private

  def link_params
    params.require(:link).permit(:title, :description, :url, :user_id)
  end
end
