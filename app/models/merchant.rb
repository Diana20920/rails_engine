class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def self.paginate(page = 1, per_page = 20)
    page = (page || 1).to_i if page < 1
    limit(per_page).offset((page - 1) * per_page)
  end
end
