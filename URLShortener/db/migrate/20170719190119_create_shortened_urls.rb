class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url
      t.string :short_url
      t.integer :creator_id, null: false
      t.timestamps
    end
    add_index :shortened_urls, :short_url, unique: true
  end
end
