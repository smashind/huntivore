class AddPerPersonToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :per_person, :boolean, default: true
  end
end
