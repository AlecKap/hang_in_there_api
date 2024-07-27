class PostersSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :price, :year, :vintage, :img_url

  def self.meta(posters)
    { count: posters.count }
  end
end
