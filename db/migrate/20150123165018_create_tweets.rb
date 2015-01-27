class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :title
      t.text :text
      t.string :twitter_post_id
      t.string :created_at
      t.string :modified_at
      t.string :timestamps

      t.timestamps
    end
  end
end
