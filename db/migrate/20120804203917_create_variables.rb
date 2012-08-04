class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.integer :question_id
      t.string :format
      t.integer :minimum
      t.integer :maximum
      t.integer :multiple

      t.timestamps
    end
  end
end
