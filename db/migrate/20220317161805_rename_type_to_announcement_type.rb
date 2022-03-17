class RenameTypeToAnnouncementType < ActiveRecord::Migration[6.1]
  def change
    rename_column :announcements, :type, :announcement_type
  end
end
