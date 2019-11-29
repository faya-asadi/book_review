require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Validation' do
    it 'requires title' do
      book = Book.new(title: '')
      expect(book.valid?).to be_falsy
      expect(book.errors[:title]).not_to be_empty
    end
    it 'requires author' do
      book = Book.new(author: '')
      expect(book.valid?).to be_falsy
      expect(book.errors[:author]).not_to be_empty
    end
    it 'the title length should not be lass than 3' do
      book = Book.new(title: 'la')
      expect(book.valid?).to be_falsy
      expect(book.errors[:title]).not_to be_empty
    end
    it 'the title length should not be more than 60' do
      book = Book.new(title: 'l'*61)
      expect(book.valid?).to be_falsy
      expect(book.errors[:title]).not_to be_empty
    end
    it 'the title of book should be unique' do
      book = FactoryBot.create(:book)
      new_book = Book.new(title: book.title)
      expect(new_book.valid?).to be_falsy
      expect(new_book.errors[:title]).not_to be_empty
    end

    it 'belongs to a user' do
      book = Book.new(user: nil)
      expect(book.valid?).to be_falsy
      expect(book.errors[:user]).not_to be_empty
    end

  end
end
