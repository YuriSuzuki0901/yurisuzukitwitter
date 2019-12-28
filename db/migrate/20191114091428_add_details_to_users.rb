class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :cl_image, :string
    add_column :users, :profile, :text



  end
end
