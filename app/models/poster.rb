class Poster < ApplicationRecord

  def self.order_by_created_at_asc
    order(created_at: :asc)
  end

  def self.order_by_created_at_desc
    order(created_at: :desc)
  end

  def self.search_by_name(search)
    where('name ILIKE ?', "%#{search}%").order(:name)
  end

  def self.filter_by_max_price(max_price)
    where('price <= ?', max_price).order(:price)
  end
  
  def self.filter_by_min_price(min_price)
    where('price >= ?', min_price).order(:price)
  end
end
