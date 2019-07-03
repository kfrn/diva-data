class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :title
      t.integer :year
      t.string :release_month
      t.integer :release_year
      t.string :imdb_id

      t.timestamps
    end
  end
end
