class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.references :author, foreign_key: { to_table: :profiles }
      t.references :topic, foreign_key: { to_table: :topics }

      t.integer :relative_id

      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
