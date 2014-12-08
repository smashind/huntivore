class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :properties, :type, :hunttype
  end
end
