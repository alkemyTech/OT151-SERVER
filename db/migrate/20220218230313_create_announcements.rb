class CreateAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
