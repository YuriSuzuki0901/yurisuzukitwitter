class AddclImageToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :cl_image, :string
  end
end
