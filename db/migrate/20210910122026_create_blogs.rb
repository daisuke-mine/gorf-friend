class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      
      t.integer :client_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
