class CreateLocation < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :country
      t.string :city
      t.string :area
      t.string :street
      t.float :latitude
      t.float :longitude
      t.references :user

      t.timestamps
    end

    add_reference :users, :location, foreign_key: true
  end
end
