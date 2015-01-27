class CreateYoutubes < ActiveRecord::Migration
  def change
    create_table :youtubes do |t|
      t.string :title
      t.string :url
      t.string :youtube_id
      t.string :thumbnail

      t.timestamps
    end
  end
end
