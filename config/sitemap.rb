# Set the host name for URL creation
#SitemapGenerator::Sitemap.default_host = "http://www.example.com"

#SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
#end

SitemapGenerator::Sitemap.default_host = ENV['SITEMAP_DEFAULT_HOST']
# 出力先のパスを変更したい場合は以下を有効化
# SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  add news_show_path, priority: 0.7, changefreq: 'daily'
  add article_path, priority: 0.7, changefreq: 'daily'
  add browse_path, priority: 0.7, changefreq: 'daily'

  Shop.all.each do |shop|
    category = ContentCategory.type_root(shop, ContentCategory::TYPE_NEWS)
    articles = category.public_leafs(true).order(updated_at: :desc).limit(10)
    articles.each do |art|
      add news_show_path(id: art, wkey: shop.wsite_hash_key), priority: 1.0, lastmod: art.updated_at, changefreq: 'daily'
    end

    category = ContentCategory.type_root(shop, ContentCategory::TYPE_STREAM)
    articles = category.public_leafs(true).order(updated_at: :desc).limit(10)
    articles.each do |art|
      add stream_show_path(id: art, wkey: shop.wsite_hash_key), priority: 1.0, lastmod: art.updated_at, changefreq: 'daily'
    end

    category = ContentCategory.type_root(shop, ContentCategory::TYPE_GALLERY)
    articles = category.public_leafs(true).order(updated_at: :desc).limit(10)
    articles.each do |art|
      add gallery_show_path(id: art, wkey: shop.wsite_hash_key), priority: 1.0, lastmod: art.updated_at, changefreq: 'daily'
    end

  end
end
