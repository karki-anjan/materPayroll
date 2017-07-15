class AddPaidToPayslips < ActiveRecord::Migration[5.0]
  def change
    add_column :payslips, :paid, :boolean, default: false
  end
end
