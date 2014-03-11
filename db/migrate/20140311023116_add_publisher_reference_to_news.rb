class AddPublisherReferenceToNews < ActiveRecord::Migration
  def change
  	add_column :news, :user_id, :integer
  	add_index :news, :slug, unique: true
  end
end
