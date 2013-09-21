class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.datetime :pictured_at
      t.string :picture_file_name
      t.string :picture_content_type
      t.datetime :picture_updated_at
      t.integer :picture_file_size

      t.timestamps
    end
  end
end
