class <%= migration_class_name %> < ActiveRecord::Migration
  def up
    remove_index :<%= table_name %>, :<%= attribute.index_name %><%= attribute.inject_index_options %>
  end

  def down
    add_index :<%= table_name %>, :<%= attribute.index_name %><%= attribute.inject_index_options %>
  end
end
