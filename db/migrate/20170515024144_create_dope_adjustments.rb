class CreateDopeAdjustments < ActiveRecord::Migration[5.0]
  def change
    create_table :dope_adjustments do |t|
      t.string :description
      t.decimal :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :dope_adjustments, [:user_id, :created_at]
  end
end
