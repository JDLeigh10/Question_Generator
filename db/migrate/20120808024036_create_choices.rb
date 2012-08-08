class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :choice_text
      t.boolean :correct

      t.timestamps
    end
  end
end
