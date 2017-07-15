class AddOtherInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :contact_no, :string
    add_column :users, :account_no, :string
    add_column :users, :bank, :string
    add_column :users, :base_salary, :int
    add_column :users, :no_of_dependents, :int
    add_column :users, :address, :string
    add_column :users, :sss_no, :string
    add_column :users, :tin_no, :string
    add_column :users, :pagibig_no, :string
    add_column :users, :philhealth_no, :string
    add_column :users, :position, :string
    add_column :users, :job, :string
  end
end
