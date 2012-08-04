class AddNumberToVariables < ActiveRecord::Migration
  def change
    add_column :variables, :number, :integer
  end
end
