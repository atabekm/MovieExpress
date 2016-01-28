class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :star
      t.references :user, index: true
      t.references :movie, index: true

      t.timestamps
    end
  end
end
