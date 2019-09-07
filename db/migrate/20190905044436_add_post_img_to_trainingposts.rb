class AddPostImgToTrainingposts < ActiveRecord::Migration[5.2]
  def change
    add_column :trainingposts, :post_img, :json
  end
end
