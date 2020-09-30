class CreateContent < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.integer :views_count, default: 0

      t.timestamps
    end
  end
end
