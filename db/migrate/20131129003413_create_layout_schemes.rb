# -*- encoding : utf-8 -*-
class CreateLayoutSchemes < ActiveRecord::Migration
  def self.up
    create_table :layout_schemes do |t|
      t.string  :name
      t.text    :description
      t.integer :position
      t.boolean :is_public, :default=>false
      t.string  :repository_path
      
      t.timestamps
    end
    LayoutScheme.create(:name=>"Modern Business",    :repository_path=>"modern-business",   :is_public=>true)    
    LayoutScheme.create(:name=>"Business Casual",    :repository_path=>"business-casual",   :is_public=>true)    
    LayoutScheme.create(:name=>"Monster",            :repository_path=>"monster",           :is_public=>true)    
    LayoutScheme.create(:name=>"Monster Silver",     :repository_path=>"monster-silver",    :is_public=>true)    
    LayoutScheme.create(:name=>"Stylish Portfolio",  :repository_path=>"stylish-portfolio", :is_public=>true)    
  end

  def self.down
    drop_table :layout_schemes
  end
end
