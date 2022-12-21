class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :username, null: false, default: "Anonymous"
      t.string :avatar_seed, null: false
      t.timestamps
    end
  end
end
