# -*- encoding : utf-8 -*-
class CreateVisualWidgets < ActiveRecord::Migration
  def self.up
    create_table :visual_widgets do |t|
      t.integer   :layout_scheme_id
      t.string    :hash_key
      t.integer   :position
      
      t.integer   :widget_type,       :default=>VisualWidget::WIDGET_TYPE_STRING

      t.string    :title
      t.string    :description

      t.timestamps
    end
    add_index :visual_widgets, :layout_scheme_id
    add_index :visual_widgets, :hash_key
    
    
    ###
    ##  Setup Widget For Default Templates
    #
    ###
    ##  For 'Modern Business'
    #
    layout = LayoutScheme.find_by_name("Modern Business")
    unless layout.blank?
      VisualWidget.create(:hash_key=>'fa2b3ba78546c4161a2c716c0b1a138a', :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"スモール・ロゴ",    :description=>"ナビゲーションバー左端に表示されるロゴ画像です。70x40ピクセル程度が目安となります。")
      VisualWidget.create(:hash_key=>'cffec5a742aae4d0d48cd9ea8f475e4e', :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTOS, :title=>"スライドショー画像", :description=>"トップページのスライドショー画像です。1024x768ピクセル程度の画像を５枚まで。全て同一の大きさの画像を選択されることを推奨します。")
    end
    ###
    ##  For 'Business Casual'
    #
    layout = LayoutScheme.find_by_name("Business Casual")
    unless layout.blank?
      VisualWidget.create(:hash_key=>'9e3014319eeedd3b2a9344c8b1a971a7', :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"トップページ背景画像画像", :description=>"トップページの背景画像です。大型の画像を指定されることを推奨します。")
      VisualWidget.create(:hash_key=>'c2f0419ca1dd69a31990dc1c272935d9', :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"トップ・ロゴ",           :description=>"ページ上部に表示されるロゴ画像です。250x75ピクセル程度が目安となります。")
      VisualWidget.create(:hash_key=>'a54200a47502a3e8ef989f99a9ee146c', :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTOS, :title=>"スライドショー画像",       :description=>"トップページのスライドショー画像です。1024x768ピクセル程度の画像で、全て同一の大きさの画像を選択されることを推奨します。")
      VisualWidget.create(:hash_key=>'08ea7eacf890e119bd4ace9acd7ca8a7', :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"スモール・ロゴ",          :description=>"スマートフォン等、ナビゲーションバー内に表示されるロゴファイルです。70x40ピクセル程度が目安となります。")
    end
    ###
    ##  For 'Monster'
    #
    layout = LayoutScheme.find_by_name("Monster")
    unless layout.blank?
      VisualWidget.create(:hash_key=>'2a3cb29deab30772464ed1eb07518f88', :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"ロゴ画像",         :description=>"ナビゲーションバー左端に表示されるロゴ画像です。100x75ピクセル程度が目安となります。")
      VisualWidget.create(:hash_key=>'bc9d8dc92e5beace5fc8071431b5406d', :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTOS, :title=>"スライドショー画像", :description=>"トップページのスライドショー画像です。770x400程度の画像で、全て同一の大きさの画像を選択されることを推奨します。")
    end
    ###
    ##  For 'Monster Silver'
    #
    layout = LayoutScheme.find_by_name("Monster Silver")
    unless layout.blank?
      VisualWidget.create(:hash_key=>'35d8e05aa00769c4db74e765e4c210d4',  :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"ロゴ画像",         :description=>"ナビゲーションバー左端に表示されるロゴ画像です。100x75ピクセル程度が目安となります。")
      VisualWidget.create(:hash_key=>'b844143945b5ea2d3bb0adf9984240ad',  :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTOS, :title=>"スライドショー画像", :description=>"トップページのスライドショー画像です。770x400程度の画像で、全て同一の大きさの画像を選択されることを推奨します。")
    end
    ###
    ##  For 'Monster Silver'
    #
    layout = LayoutScheme.find_by_name("Stylish Portfolio")
    unless layout.blank?
      VisualWidget.create(:hash_key=>'2cef44b0dd9692c245f132685b20f313',  :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"トップページ背景画像画像１",  :description=>"トップページの背景画像です。大型の画像を指定されることを推奨します。")
      VisualWidget.create(:hash_key=>'527a3266c376ced4044eb1e72151c717',  :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"トップ・ロゴ",             :description=>"トップページ中央に表示されるロゴ画像です。200x200ピクセル程度が目安となります。")
      VisualWidget.create(:hash_key=>'e3cb98852eec58ecbee79a6640f6f0ba',  :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"トップページ背景画像画像２",  :description=>"トップページの背景画像です。大型の画像で、表示させたいエリアを横長にクリップした画像を指定されることを推奨します。")
      VisualWidget.create(:hash_key=>'7ea11543a486332edd763b1bab738f55',  :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_STRING, :title=>"コールアウト文字",          :description=>"トップページ背景画像２上に表示させる文字列です。")
      VisualWidget.create(:hash_key=>'bcb621895bc594099d76e183c133ce06',  :layout_scheme_id=>layout.id, :widget_type=>VisualWidget::WIDGET_TYPE_PHOTO,  :title=>"スモール・ロゴ",            :description=>"ナビゲーションバー内に表示されるロゴファイルです。70x40ピクセル程度が目安となります。")
    end
  end

  def self.down
    drop_table :visual_widgets
  end
end
