xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title 			model_name(@website)+" ニュース"
    xml.description		@website.wsite_description_shop
    xml.link 			root_url

	unless @posts.blank?
	    for post in @posts
	      xml.item do
	        xml.title 		post.title
	        xml.pubDate 	post.publish_from.to_s(:rfc822)
	        xml.description	truncate(strip_tags(post.description).gsub('&nbsp;', ' ').gsub(/[\r\n]/,""), :length=>100)
	        xml.link 		root_url+"news_show?id=#{post.id}&wkey=#{post.shop.wsite_hash_key}"
	        xml.guid 		root_url+"news_show?id=#{post.id}&wkey=#{post.shop.wsite_hash_key}"    
	      end
	    end
  	end
  end
end
