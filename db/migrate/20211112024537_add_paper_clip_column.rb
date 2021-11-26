class AddPaperClipColumn < ActiveRecord::Migration[5.2]
  def self.up
    change_table :photos do |t|
      t.attachment :clip
    end
  end

  def self.down
    remove_attachment :photos, :clip
  end
end
