class ChangeDataPostImgToTrainingposts < ActiveRecord::Migration[5.2]
  def change
    change_column :trainingposts, :post_img, :string
  end
end
