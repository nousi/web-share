class Product < ApplicationRecord
  belongs_to :user
  belongs_to :client, class_name: "User", foreign_key: "client_id", optional: true
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :sns, through: :sns_product
  has_many :sns_product
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  validates :name, presence: true
  validates :description, presence: true
  validates :period, presence: true
  validates :price, presence: true
  validates :user_id, presence: true
  validates :name, length: { maximum: 40 }
  validates :description, length: { maximum: 300 }
  validates :price,numericality: {
    only_integer: true,
    greater_than_or_equal_to: 100,
    less_than_or_equal_to: 999999,
    allow_blank: true
  }

  validate :category_count
    def category_count
      category_validation = category_ids
      unless category_validation.length >= 1
        errors.add(:category_ids,"選択してください")
      end
    end

end
