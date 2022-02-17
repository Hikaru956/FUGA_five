# -*- encoding : utf-8 -*-
class CreatePhotos < ActiveRecord::Migration[5.2]
  def self.up
    create_table :photos do |t|
      t.integer   :shop_id
      t.text      :image
      t.text      :info
      t.integer   :position

      t.integer   :ref_id
      t.string    :ref_type

      t.integer   :my_size, :default=>0
      t.timestamps
    end
    add_index :photos, :shop_id 
    add_index :photos, [:ref_id, :ref_type] 
  end

  def self.down
    drop_table :photos
  end
end
