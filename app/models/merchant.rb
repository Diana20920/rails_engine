class Merchant < MerchantAndItem
  has_many :items, dependent: :destroy

  def self.name_includes(term)
    where("name ilike ?", "%#{term}%").order(name: :asc).first
  end
end
