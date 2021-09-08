class ChangeBrogsToBlogs < ActiveRecord::Migration[5.2]
  def change
    rename_table :brogs, :blogs
  end
end
