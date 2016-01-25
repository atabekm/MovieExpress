class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :director
      t.string :actors
      t.string :genre
      t.string :runtime
      t.string :budget

      t.timestamps
    end
  end
end
