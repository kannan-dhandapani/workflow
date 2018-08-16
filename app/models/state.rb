class State < ApplicationRecord
    has_one :trfrom, :class_name => "Transition", :foreign_key => "from_state"
    has_one :trto, :class_name => "Transition", :foreign_key => "to_state"
end
