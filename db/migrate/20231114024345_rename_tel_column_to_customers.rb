class RenameTelColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :tel, :telephone_number
  end
end
