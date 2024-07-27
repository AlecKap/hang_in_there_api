class Api::V1::PostersController < ApplicationController
  def index
    posters = if params[:name]
                Poster.search_by_name(params[:name])
              else
                case params[:sort]
                when 'asc'
                  Poster.order_by_created_at_asc
                when 'desc'
                  Poster.order_by_created_at_desc
                else
                  Poster.all
                end
              end
    render json: PostersSerializer.new(posters, meta: PostersSerializer.meta(posters))
  end

  def show
    poster = Poster.find(params[:id])
    render json: PostersSerializer.new(poster)
  end

  def create
    poster = Poster.new(poster_params)
    if poster.save
      render json: PostersSerializer.new(poster)
    else
      render json: ErrorSerializer.new(poster.errors), status: :unprocessable_entity
    end
  end

  def update
    poster = Poster.find(params[:id])
    poster.update(poster_params)
    render json: PostersSerializer.new(poster)
  end

  def destroy
    poster = Poster.find(params[:id])
    poster.destroy
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
  end
end