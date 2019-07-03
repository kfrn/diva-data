class AddProductionCompanyReferenceToCountry < ActiveRecord::Migration[5.2]
  def change
    add_reference :countries, :production_company, foreign_key: true
  end
end
