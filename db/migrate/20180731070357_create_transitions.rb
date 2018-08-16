class CreateTransitions < ActiveRecord::Migration[5.2]
  def up
    create_table :transitions do |t|
      t.integer "workflow_id", null: false
      t.string "name", limit: 100
      t.integer "from_state", null: false
      t.integer "to_state", null: false
      t.text "desc"
      t.timestamps
    end

    add_index("transitions", "workflow_id")
    add_index("transitions", "from_state")
    add_index("transitions", "to_state")
  end

  def down
  	drop_table :transitions
  end
end
