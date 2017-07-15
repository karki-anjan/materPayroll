class CreateAllowances < ActiveRecord::Migration[5.0]
  def change
    create_table :allowances do |t|
      t.string :description
      t.decimal :amount, :precision => 9, :scale => 2
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :allowances, [:user_id, :created_at]
  end
end
