class Book < ApplicationRecord #ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  validates :title, presence: true, length: {minimum:3, maximum:60 }
  validates :author, presence: true, length: {minumum: 4, maximum: 100}
  validates :user_id, presence: true
end
