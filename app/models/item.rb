class Item < MerchantAndItem
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.name_includes(term)
    where("name ilike ?", "%#{term}%")
  end

  def self.cost_more_than(price)
    price.to_f
    where("unit_price > ?", price)
  end

  def self.cost_less_than(price)
    price.to_f
    where("unit_price < ?", price)
  end

  def self.price_between(min, max)
    min.to_f
    max.to_f
    where("unit_price > ? and unit_price < ?", "#{min}", "#{max}" )
  end
end
