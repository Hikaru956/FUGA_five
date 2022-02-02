class ReplaceDescriptionForContentLeaf < ActiveRecord::Migration[5.2]
  def self.up
    ContentLeaf.all.each do |leaf|
      leaf.description = xlate(leaf.description)
      leaf.save!
    end

    Shop.all.each do |shop|
      shop.wsite_description_business = xlate(shop.wsite_description_business)
      shop.save!
    end

    Staff.all.each do |staff|
      next if staff.shop.blank?
      staff.description = xlate(staff.description)
      staff.save!
    end
  end
  def self.down
  end


  def xlate(description)
    return nil if description.blank?
    description = description.gsub('../../photo/','/photo/')
    description = description.gsub('../photo/','/photo/')

    description = description.gsub('/photo/image/0008/','/photo/image/clip/8')
    description = description.gsub('/photo/image/0007/','/photo/image/clip/7')
    description = description.gsub('/photo/image/0006/','/photo/image/clip/6')
    description = description.gsub('/photo/image/0005/','/photo/image/clip/5')
    description = description.gsub('/photo/image/0004/','/photo/image/clip/4')
    description = description.gsub('/photo/image/0003/','/photo/image/clip/3')
    description = description.gsub('/photo/image/0002/','/photo/image/clip/2')
    description = description.gsub('/photo/image/0001/','/photo/image/clip/1')
    description = description.gsub('/photo/image/0000/000','/photo/image/clip/')
    description = description.gsub('/photo/image/0000/00','/photo/image/clip/')
    description = description.gsub('/photo/image/0000/0','/photo/image/clip/')
    description = description.gsub('/photo/image/0000/','/photo/image/clip/')

    description = description.gsub(/clip\/\d{1,7}/,'\\0/original')
    description = description.gsub('/original/thumb/','/thumb/')
    description = description.gsub('/original/panel/','/panel/')
    description = description.gsub('/original/large/','/large/')
    #description = description.gsub(/\d{1,7}/,"\\0/original")
    #description = description.gsub('/photo/image/clip/{\d}/','/photo/image/clip/$1/original/')

    return description
  end
end
