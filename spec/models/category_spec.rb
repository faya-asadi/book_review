require 'rails_helper'

RSpec.describe Category, type: :model do

  describe 'validations' do

    it 'requires a name' do
      category = Category.new
      #category.valid?
      expect(category.valid?).to be_falsy
      expect(category.errors[:name]).to include("can't be blank")
      expect(category.errors[:name]).not_to be_empty
    end

    it 'requires name to be uniq' do
      cat_name = 'cat_name'
      first_category = FactoryBot.create(:category, name: cat_name)
      expect(first_category.valid?).to be_truthy
      new_category = Category.new(name: cat_name)
      expect(new_category.valid?).to be_falsy
    end

  end
end
