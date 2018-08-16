class CreateCriteria < ActiveRecord::Migration[5.2]
  def up
    create_table :criteria do |t|
      t.integer "transition_id", null: false
      t.integer "criteria_type", null:false
      t.string "key", limit: 100
      t.string "value", limit: 200
      t.timestamps
    end

    add_index("criteria", "transition_id")
  end

  def down
  	drop_table :criteria
  end
end
