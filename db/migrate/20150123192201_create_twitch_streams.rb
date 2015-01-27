class CreateTwitchStreams < ActiveRecord::Migration
  def change
    create_table :twitch_streams do |t|
      t.boolean :is_live

      t.timestamps
    end
  end
end
