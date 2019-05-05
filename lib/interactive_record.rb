require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end
def self.column_names
    DB[:conn].results_as_hash = true

    sql = "pragma table_info('#{table_name}')"
    table_info=DB[:conn].execute(sql)
    colume_names=[]
table_info.each do |row|
  colume_names << row["name"]
end
colume_names.compact 
end 

  def initialize(options={})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end
  def table_name_for_insert 
    self.class.table_name
  end 
  def col_names_for_insert 
    self.class.colume_names.delete_if {|col| col.name== "id"}
end 