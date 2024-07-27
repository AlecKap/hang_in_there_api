class Api::V1::PostersController < ApplicationController
  def index
    posters = Poster.all
    render json: PostersSerializer.new(posters)
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