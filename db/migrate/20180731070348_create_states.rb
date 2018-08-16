class CreateStates < ActiveRecord::Migration[5.2]
  def up
    create_table :states do |t|
      t.string "name", limit:100
      t.text "desc"
      t.timestamps
    end
  end

  def down
  	drop_table :states
  end
end
