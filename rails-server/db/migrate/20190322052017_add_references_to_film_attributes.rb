class AddReferencesToFilmAttributes < ActiveRecord::Migration[5.2]
  def change
    add_reference :countries, :film, foreign_key: true
    add_reference :people, :film, foreign_key: true
    add_reference :production_companies, :film, foreign_key: true
  end
end
