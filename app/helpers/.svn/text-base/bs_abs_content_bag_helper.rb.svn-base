# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

module BsAbsContentBagHelper
  def content_category_trees(items)
    if items.size > 0
      # ルート以外は非表示の設定で描画する
#      tree_id = "tree_#{items.first.parent_id}"
#      style_tree = tree_id == 'tree_' ? 'display:show' : 'display:none'
      tree_id     = (items.first.parent.category_type==ContentCategory::TYPE_BAG_ROOT)? "tree_": "tree_#{items.first.parent_id}"
      style_tree  = (items.first.parent.category_type==ContentCategory::TYPE_BAG_ROOT)? 'display:show' : 'display:none'

      html = "<ul id='#{tree_id}' style='#{style_tree}' class='tree'><li></li>"
      
      items.each do |item|
        html << "<li id='item_#{item.id}'>"
        
        # 折畳み、展開マーク ≫ ∨ の描画
        if item.children.size > 0
          style_show = 'display:none'
        else
          style_hide = 'display:none'
        end
        html << link_to_function(image_tag("commons/tree_collapse_16x16.png",:class=>"icon_align"), 
                  "Element.toggle('tree_#{item.id}');
                   Element.toggle('show_#{item.id}');
                   Element.toggle('hide_#{item.id}')", 
                  :class=>"toggle_show", :id=>"show_#{item.id}", :style=>style_show)
        html << link_to_function(image_tag("commons/tree_expand_16x16.png",:class=>"icon_align"), 
                  "Element.toggle('tree_#{item.id}');
                   Element.toggle('show_#{item.id}');
                   Element.toggle('hide_#{item.id}')", 
                  :class=>"toggle_hide", :id=>"hide_#{item.id}", :style=>style_hide)

        # リスト名称を描画、この部分をドラッグする時にマウスで握る部分として設定
        html << "&nbsp;<span class='handle'>#{h(item.category_label)}</span>"
        
        # 子追加、削除の操作リンクを設定
        html << "&nbsp;&nbsp;"
        html << link_to(image_tag("commons/edit_16x16.png", :class=>'icon_align', :title=>"編集"),   {:action=>'content_category_edit', :id=>item},    :remote=>true, :class=>'tree_action')
        html << "&nbsp;&nbsp;"
        html << link_to(image_tag("commons/stop_16x16.png",:class=>"icon_align", :title=>"削除確認"), {:action=>'content_catefory_delete', :id=>item,   :remote=>true, :confirm=>"このカテゴリー【 #{item.title} 】とサブカテゴリーに関連する全ての情報も削除されます。"}, :method => "post", :class=>'tree_action')

        # 子の存在を確認して、存在していたらcategory_treesを再帰呼出し
        if item.children.size > 0
          html << content_category_trees(item.children)
        else
          html << "<ul id='tree_#{item.id}'><li></li></ul>"
        end
        html << "</li>"
      end
      html << "</ul>"
    end
  end
end
