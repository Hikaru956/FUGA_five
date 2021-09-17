# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_11_064725) do

  create_table "attendances", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "staff_id"
    t.date "attend_on"
    t.integer "start_hour"
    t.integer "until_hour"
    t.integer "attend_period"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attend_on"], name: "index_attendances_on_attend_on"
    t.index ["shop_id"], name: "index_attendances_on_shop_id"
    t.index ["staff_id"], name: "index_attendances_on_staff_id"
  end

  create_table "color_schemes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "position"
    t.boolean "is_public", default: false
    t.string "repository_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "alt_id"
    t.string "name"
    t.string "postal"
    t.string "address_1"
    t.string "address_2"
    t.string "telephone_1"
    t.string "telephone_2"
    t.string "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_bags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "parent_id"
    t.integer "position"
    t.string "hash_key"
    t.integer "content_type"
    t.integer "content_category_id"
    t.integer "web_page_id"
    t.string "name"
    t.text "description"
    t.boolean "is_public", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "parent_id"
    t.integer "position"
    t.integer "category_type"
    t.integer "web_page_id"
    t.string "title"
    t.text "description"
    t.text "description_2"
    t.text "description_3"
    t.integer "integer_field"
    t.integer "integer_field_2"
    t.integer "integer_field_3"
    t.boolean "is_public", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_leafs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "content_bag_id"
    t.integer "content_category_id"
    t.integer "staff_id"
    t.string "hash_key"
    t.integer "position"
    t.string "title"
    t.text "description"
    t.text "description_2"
    t.text "description_3"
    t.integer "integer_field"
    t.integer "integer_field_2"
    t.integer "integer_field_3"
    t.string "link_title"
    t.text "link_url"
    t.boolean "is_open_new", default: false
    t.string "link_title_2"
    t.text "link_url_2"
    t.boolean "is_open_new_2", default: false
    t.string "link_title_3"
    t.text "link_url_3"
    t.boolean "is_open_new_3", default: false
    t.boolean "is_public", default: false
    t.date "publish_from"
    t.date "publish_until"
    t.boolean "is_hot", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "company_id"
    t.integer "shop_id"
    t.string "alt_id"
    t.string "name"
    t.string "furigana"
    t.string "email"
    t.string "telephone"
    t.string "telephone_2"
    t.string "postal_code"
    t.text "address"
    t.text "address_2"
    t.date "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["alt_id"], name: "index_customers_on_alt_id"
    t.index ["birthday"], name: "index_customers_on_birthday"
    t.index ["company_id"], name: "index_customers_on_company_id"
    t.index ["shop_id"], name: "index_customers_on_shop_id"
  end

  create_table "layout_schemes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "position"
    t.boolean "is_public", default: false
    t.string "repository_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "shop_id"
    t.text "image"
    t.text "info"
    t.integer "position"
    t.integer "ref_id"
    t.string "ref_type"
    t.integer "my_size", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ref_id", "ref_type"], name: "index_photos_on_ref_id_and_ref_type"
    t.index ["shop_id"], name: "index_photos_on_shop_id"
  end

  create_table "reservations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "shop_id"
    t.integer "staff_id"
    t.datetime "reserved_on"
    t.datetime "reserved_until"
    t.integer "min_period"
    t.text "memo_1"
    t.text "memo_2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["customer_id"], name: "index_reservations_on_customer_id"
    t.index ["shop_id"], name: "index_reservations_on_shop_id"
  end

  create_table "roster_labels", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "shop_id"
    t.string "name"
    t.integer "start_hour"
    t.integer "until_hour"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shops", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "company_id"
    t.integer "position"
    t.integer "parent_id"
    t.string "alt_id"
    t.string "name"
    t.string "postal"
    t.string "address_1"
    t.string "address_2"
    t.string "telephone_1"
    t.string "telephone_2"
    t.string "fax"
    t.integer "business_hour_from", default: 9
    t.integer "business_hour_until", default: 21
    t.float "lat"
    t.float "lng"
    t.boolean "option_attendance_management", default: false
    t.boolean "option_customer_management", default: false
    t.boolean "option_reservation_management", default: false
    t.boolean "option_sales_management", default: false
    t.integer "room_size_mb"
    t.integer "wsite_run_mode", default: 10
    t.string "wsite_hash_key"
    t.integer "wsite_color_deploy_id"
    t.integer "wsite_layout_deploy_id"
    t.integer "wsite_color_edit_id"
    t.integer "wsite_layout_edit_id"
    t.string "wsite_layout_pc_specific_basename"
    t.string "wsite_keywords"
    t.string "wsite_description_shop"
    t.string "wsite_description_business"
    t.string "wsite_telephone"
    t.string "wsite_email"
    t.string "social_facebook_uri"
    t.string "social_gplus_uri"
    t.string "social_twitter_uri"
    t.string "social_blogger_uri"
    t.string "social_pinterest_uri"
    t.string "social_tumblr_uri"
    t.string "google_calendar_url"
    t.text "google_calendar_emb_frame_code"
    t.string "wsite_ga_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "use_disqus", default: false
    t.text "disqus_code"
    t.text "analytics_code"
    t.text "custom_metas"
    t.string "copyright_notice"
    t.string "social_instagram_uri"
    t.index ["wsite_hash_key"], name: "index_shops_on_wsite_hash_key"
  end

  create_table "staffs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "position"
    t.string "alt_id"
    t.string "name"
    t.string "job_title"
    t.text "description"
    t.integer "staff_status", default: 100
    t.string "social_facebook_uri"
    t.string "social_gplus_uri"
    t.string "social_twitter_uri"
    t.string "social_blogger_uri"
    t.string "social_pinterest_uri"
    t.string "social_tumblr_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "social_instagram_uri"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "login", limit: 40
    t.string "name", limit: 100, default: ""
    t.string "email", limit: 100
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "password_salt", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "remember_token", limit: 40
    t.datetime "remember_token_expires_at"
    t.integer "role", default: 5
    t.integer "company_id"
    t.integer "shop_id"
    t.integer "try_count", default: 0
    t.datetime "confirmation_sent_at"
    t.datetime "remember_created_at"
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "visual_widget_bags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "visual_widget_id"
    t.string "data_string"
    t.text "data_text"
    t.string "data_url"
    t.boolean "data_boolean", default: false
    t.text "data_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["shop_id"], name: "index_visual_widget_bags_on_shop_id"
    t.index ["visual_widget_id"], name: "index_visual_widget_bags_on_visual_widget_id"
  end

  create_table "visual_widgets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "layout_scheme_id"
    t.string "hash_key"
    t.integer "position"
    t.integer "widget_type", default: 10
    t.string "title"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["hash_key"], name: "index_visual_widgets_on_hash_key"
    t.index ["layout_scheme_id"], name: "index_visual_widgets_on_layout_scheme_id"
  end

  create_table "web_pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "parent_id"
    t.integer "position"
    t.integer "content_type"
    t.integer "page_type"
    t.integer "template_name"
    t.string "controller_name", default: "bs_renderer"
    t.string "action_name"
    t.string "content_key"
    t.string "name"
    t.boolean "is_public", default: true
    t.string "external_url"
    t.boolean "is_open_new", default: false
    t.text "frame_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
