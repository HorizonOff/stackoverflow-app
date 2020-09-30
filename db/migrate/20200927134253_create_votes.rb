class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.boolean :up
      t.references :user, index: true
      t.references :message, index: true

      t.timestamps
    end
  end
end
