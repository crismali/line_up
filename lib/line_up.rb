require "active_support"
require "active_record"

require "line_up/version"

module LineUp
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.send(:include, LineUp)
end
