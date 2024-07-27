class Api::V1::PostersController < ApplicationController
  def index
    posters = Poster.all
    render json: PostersSerializer.new(posters)
  end
end