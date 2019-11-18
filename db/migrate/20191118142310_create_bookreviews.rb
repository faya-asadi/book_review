class CreateBookreviews < ActiveRecord::Migration[5.1]
  def change
    create_table :bookreviews do |t|
      t.integer :book_id
      t.integer :rate
      t.text :review, null: true
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_foreign_key :bookreviews, :books, column: :book_id, primary_key: "id", null: false
    #add_reference :bookreviews, :books, foreign_key: true
    #add_foreign_key :bookreviews, :books
    #add_foreign_key :bookreviews, :books, column: :book_id, primary_key: "id"
  end
end
