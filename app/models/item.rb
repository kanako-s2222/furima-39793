class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_price
  belongs_to :place
  belongs_to :delivery_day

  belongs_to :user
  has_one_attached :image
  #has_one :order

  validates :item_name, presence: true
  validates :explain, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :delivery_price_id, presence: true
  validates :place_id, presence: true
  validates :delivery_day_id, presence: true
  validates :price, presence: true
  validates :price, numericality: { in: 300..9_999_999, only_integer: true }
  validates :image, presence: true

  validates :category_id, :condition_id, :delivery_price_id, :place_id, :delivery_day_id,
            numericality: { other_than: 1, message: "can't be blank" }
end
