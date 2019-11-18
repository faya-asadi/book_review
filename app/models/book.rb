class Book < ApplicationRecord #ActiveRecord::Base
  validates :title, presence: true, length: {minimum:3, maximum:60 }
  validates :author, presence: true, length: {minumum: 4, maximum: 100}  
end
