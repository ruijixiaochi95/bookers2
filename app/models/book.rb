class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  validates :introduction, presence: false
end
