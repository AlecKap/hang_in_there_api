class Api::V1::PostersController < ApplicationController
  def index
    posters = Poster.all
    render json: PostersSerializer.new(posters)
  end

  def show
    poster = Poster.find_by(id: params[:id])
    render json: PostersSerializer.new(poster)
  end
end