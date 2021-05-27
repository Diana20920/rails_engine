class Merchant < MerchantAndItem
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.name_includes(term)
    where("name ilike ?", "%#{term}%").order(name: :asc).first
  end

  def total_revenue
    transactions
    .where("invoices.status = 'shipped'")
    .where("transactions.result = 'success'")
    .pluck("(invoice_items.quantity * items.unit_price) AS revenue")
    .sum
  end
end
