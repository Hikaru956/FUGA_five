# -*- encoding : utf-8 -*-
class CreateColorSchemes < ActiveRecord::Migration
  def self.up
    create_table :color_schemes do |t|
      t.string  :name
      t.text    :description
      t.integer :position
      t.boolean :is_public, :default=>false
      t.string  :repository_path
      
      t.timestamps
    end
    ColorScheme.create(:name=>"Lavish-0",    :repository_path=>"lavish-bootstrap-0",  :is_public=>true)    
    ColorScheme.create(:name=>"Lavish-1",    :repository_path=>"lavish-bootstrap-1",  :is_public=>true)    
    ColorScheme.create(:name=>"Lavish-2",    :repository_path=>"lavish-bootstrap-2",  :is_public=>true)    
    ColorScheme.create(:name=>"Lavish-3",    :repository_path=>"lavish-bootstrap-3",  :is_public=>true)    
    ColorScheme.create(:name=>"Lavish-4",    :repository_path=>"lavish-bootstrap-4",  :is_public=>true)    
    ColorScheme.create(:name=>"Lavish-5",    :repository_path=>"lavish-bootstrap-5",  :is_public=>true)    
    ColorScheme.create(:name=>"Lavish-6",    :repository_path=>"lavish-bootstrap-6",  :is_public=>true)    
    ColorScheme.create(:name=>"Lavish-7",    :repository_path=>"lavish-bootstrap-7",  :is_public=>true)    
    ColorScheme.create(:name=>"Lavish-8",    :repository_path=>"lavish-bootstrap-8",  :is_public=>true)    
  end

  def self.down
    drop_table :color_schemes
  end
end
