class AddYtUrlToVideos < ActiveRecord::Migration
  def change
    add_column :youtubes, :yturl, :string
  end
end
