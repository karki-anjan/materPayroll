class AddProfileimfToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profileimg, :string
  end
end
