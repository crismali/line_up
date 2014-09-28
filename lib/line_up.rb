require "active_support"
require "active_record"

require "line_up/version"

module LineUp
  class UndefinedColumnError < StandardError
  end

  def line_up!(ids, column = :position)
    if column_names.exclude?(column.to_s)
      raise UndefinedColumnError, "a column named '#{column}' does not exist on the #{table_name} table"
    end

    new_position_query = ids.map.with_index do |id, index|
      sanitized_id = sanitize_sql(id: id)
      "UPDATE #{table_name} SET #{column} = #{index} WHERE #{sanitized_id};"
    end.join("\n")

    connection.execute(new_position_query)
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.send(:extend, LineUp)
end
