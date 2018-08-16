class Transition < ApplicationRecord
    belongs_to :workflow_template, { :foreign_key => 'workflow_id', optional: false }

    has_many :criteria
    belongs_to :from_state, :class_name => "State"
    belongs_to :to_state, :class_name => "State"
end