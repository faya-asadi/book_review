class Book < ApplicationRecord #ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  validates :title, presence: true, uniqueness: true, length: {minimum:3, maximum:60 }
  validates :author, presence: true, length: {minumum: 4, maximum: 100}
  #validates :user_id, presence: true

  def rate
    sum = 0
     reviews.each do |r|
       sum += r.rate
     end
     (sum.to_f / reviews.length).round(1)
  end


  after_commit {               
    MessageBroadcastJob.perform_later(self) 
  }
end
