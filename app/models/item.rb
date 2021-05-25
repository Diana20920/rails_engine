class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.paginate(page = 1, per_page = 20)
    limit(per_page).offset((page - 1) * per_page)
  end
end
