class CreateNopeAdjustments < ActiveRecord::Migration[5.0]
  def change
    create_table :nope_adjustments do |t|
      t.string :description
      t.decimal :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :nope_adjustments, [:user_id, :created_at]
  end
end
