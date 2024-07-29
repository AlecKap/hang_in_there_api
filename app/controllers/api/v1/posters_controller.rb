class Api::V1::PostersController < ApplicationController
  before_action :find_poster, only: [:show, :update, :destroy]
  def index
    posters = fetch_posters
    render json: PostersSerializer.new(posters, meta: PostersSerializer.meta(posters))
  end

  def show
    begin
      render json: PostersSerializer.new(@poster), status: 200
    rescue
      render json: ErrorSerializer.serializer("Record not found", "404"), status: 404
    end
  end

  def create
    begin
      poster = Poster.new(poster_params)
      poster.save!
      render json: PostersSerializer.new(poster), status: 201
    rescue => exception
      render json: ErrorSerializer.serializer("#{exception.message.sub("Validation failed: ", "")}", "422"), status: 422
    end
  end

  def update
    begin
      @poster.update!(poster_params)
      render json: PostersSerializer.new(poster), status: 200
    rescue => exception
      render json: ErrorSerializer.serializer("#{exception.message.sub("Validation failed: ", "")}", "422"), status: 422
    end    
  end

  def destroy
    @poster.destroy
  end

  private

  def fetch_posters
    if params[:name]
      Poster.search_by_name(params[:name])
    elsif params[:max_price]
      Poster.filter_by_max_price(params[:max_price])
    elsif params[:min_price]
      Poster.filter_by_min_price(params[:min_price])
    else
      sort_posters
    end
  end
  
  def sort_posters
    case params[:sort]
    when 'asc'
      Poster.order_by_created_at_asc
    when 'desc'
      Poster.order_by_created_at_desc
    else
      Poster.all
    end
  end

  def find_poster
    @poster = Poster.find(params[:id])
  end

  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
  end
end