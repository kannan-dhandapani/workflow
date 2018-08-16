class CreateWorkflowTemplates < ActiveRecord::Migration[5.2]
  def up
    create_table :workflow_templates do |t|
      t.string "name", limit:100
      t.string "initial_state", limit:100, null: false
      t.text "desc"
      t.timestamps
    end
  end

  def down
  	drop_table :workflow_templates
  end
end
