class CreateBrogs < ActiveRecord::Migration[5.2]
  def change
    create_table :brogs do |t|
      
      t.integer :client_id
      t.string :title
      t.text :body
      

      t.timestamps
    end
  end
end
