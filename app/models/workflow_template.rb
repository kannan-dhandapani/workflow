class WorkflowTemplate < ApplicationRecord
    has_many :transitions, { :foreign_key => "workflow_id" }

    #named scopes
    scope :newest_first, lambda { order("created_at DESC")}
end
