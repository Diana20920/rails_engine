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
    .where(Arel.sql("invoices.status = 'shipped'"))
    .where(Arel.sql("transactions.result = 'success'"))
    .sum(Arel.sql("invoice_items.quantity * items.unit_price"))
    # Great caution should be taken to avoid SQL injection vulnerabilities. This method should not be used with unsafe values such as request parameters or model attributes.
  end
end
