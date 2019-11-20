
class Review <ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :rate, presence: true, inclusion: {in: 1..5, message: "%{value} is not a valid rate"}
  validates :review, presence: true, if: :rate_less_than_3
  validates :book_id, presence: true
  validates :user_id, presence: true

  def rate_less_than_3
    rate && rate < 3
  end

end
