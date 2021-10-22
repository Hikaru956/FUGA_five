# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
RAILS_ROOT = Rails.root

BRAND_NAME = "swifty"

COLOR_ASSETS = "/stylesheets/colors"
LAYOUT_ASSETS = "layouts/assets"

PER_PAGE = 50

MAKE_SECRET_FUGA_OPTION = true

ROOM_SIZE_MB_INIT  = 1024

BIRTHDAY_BIAS_DAYS = 30

CONTENT_CATEGORY_TITLE_HOME       = "ホーム" 
CONTENT_CATEGORY_TITLE_NEWS       = "ニュース" 
CONTENT_CATEGORY_TITLE_STREAM     = "ブログ" 
CONTENT_CATEGORY_TITLE_GALLERY    = "ギャラリー"
CONTENT_CATEGORY_TITLE_PORTFOLIO  = "価格表"
CONTENT_CATEGORY_TITLE_INFO       = "店舗案内" 
CONTENT_CATEGORY_TITLE_ANONYMOUS  = "その他" 

MAKE_SECRET_FUGA_OPTION = true

USER_AUTH_FAIL_COUNT = 3
