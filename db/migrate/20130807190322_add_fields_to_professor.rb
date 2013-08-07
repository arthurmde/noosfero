class AddFieldsToProfessor < ActiveRecord::Migration
  def self.up
  	add_column :profiles, :lattes, :string
  	add_column :profiles, :fields_of_interest, :string
  end

  def self.down
  	remove_column :profiles, :lattes
  	remove_column :profiles, :fields_of_interest
  end
end
