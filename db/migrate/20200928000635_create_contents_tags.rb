class CreateContentsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :contents_tags do |t|
      t.references :content, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
