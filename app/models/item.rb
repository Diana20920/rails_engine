class Item < MerchantAndItem
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.name_includes(term)
    Item.where("name ilike ?", "%#{term}%")
  end
end
