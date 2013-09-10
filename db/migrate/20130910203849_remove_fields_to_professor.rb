class RemoveFieldsToProfessor < ActiveRecord::Migration
  def self.up
  	remove_column :profiles, :lattes
  	remove_column :profiles, :fields_of_interest
  end

  def self.down
  	add_column :profiles, :lattes, :string
  	add_column :profiles, :fields_of_interest, :string
  end
end
