class AddDisqusFeature < ActiveRecord::Migration
  def self.up
    add_column(:shops, :use_disqus,   :boolean, :default=>false)
    add_column(:shops, :disqus_code,  :text)
  end

  def self.down
    remove_column(:shops, :use_disqus)
    remove_column(:shops, :disqus_code)
  end
end
