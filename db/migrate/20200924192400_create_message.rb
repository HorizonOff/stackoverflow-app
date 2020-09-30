class CreateMessage < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.boolean :answer, default: false
      t.integer :vote_score, default: 0
      t.references :content, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
