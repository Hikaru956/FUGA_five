class ShopsController < ApplicationController
    private
    def shop_params
        params.require(:shop).permit(:alt_id, :name, :business_hour_from, :business_hour_until, :postal, :address_1, :wsite_run_mode, :wsite_keywords, :wsite_description_shop, :wsite_description_business, :wsite_telephone, :telephone_1, :wsite_email, :google_calendar_url, :google_calendar_emb_frame_code, :wsite_layout_pc_specific_basename, :social_facebook_uri, :social_gplus_uri, :social_twitter_uri, :social_pinterest_uri, :social_tumblr_uri, :social_instagram_uri, :use_disqus, :disqus_code, :wsite_ga_code, :analytics_code, :custom_metas, :copyright_notice)
    end
end
