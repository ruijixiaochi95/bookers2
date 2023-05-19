class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  validates :introduction, presence: false
  validates :body, length: { maximum: 200 },presence: true
  validates :title, presence: true
end
