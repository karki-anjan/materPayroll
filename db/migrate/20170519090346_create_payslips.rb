class CreatePayslips < ActiveRecord::Migration[5.0]
  def change
    create_table :payslips do |t|
      t.references :employee, foreign_key: true
      t.references :payroll, foreign_key: true
      t.decimal :base_salary, precision: 10, scale: 2
      t.decimal :sss, precision: 6, scale: 2
      t.decimal :pagibig, precision: 6, scale: 2
      t.decimal :philhealth, precision: 6, scale: 2
      

      t.timestamps
    end
  end
end
