class Merchant < MerchantAndItem
  has_many :items, dependent: :destroy
end
