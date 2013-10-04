class AddUploadedToLogos < ActiveRecord::Migration
  def change
    add_column :logos, :uploaded, :boolean, :default => false
  end
end
