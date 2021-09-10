class CreateBlogComments < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_comments do |t|
      
      t.integer :client_id
      t.integer :brog_id
      t.text :comment

      t.timestamps
    end
  end
end
