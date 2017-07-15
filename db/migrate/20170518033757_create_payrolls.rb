class CreatePayrolls < ActiveRecord::Migration[5.0]
  def change
    create_table :payrolls do |t|
      t.date :start_period
      t.date :end_period

      t.timestamps
    end

    add_index :payrolls, [:created_at]
  end
end
