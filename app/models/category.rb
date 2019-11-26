class Category < ApplicationRecord
  validates :name, presence: true

  def initialize(name)
  end
end
