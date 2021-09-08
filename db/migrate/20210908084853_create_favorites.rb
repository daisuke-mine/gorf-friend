class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      
      t.integer :client_id
      t.integer :brog_id

      t.timestamps
    end
  end
end
