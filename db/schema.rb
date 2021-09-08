# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20210811064725) do

  create_table "attendances", force: :cascade do |t|
    t.integer  "shop_id",       limit: 4
    t.integer  "staff_id",      limit: 4
    t.date     "attend_on"
    t.integer  "start_hour",    limit: 4
    t.integer  "until_hour",    limit: 4
    t.integer  "attend_period", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["attend_on"], name: "index_attendances_on_attend_on", using: :btree
  add_index "attendances", ["shop_id"], name: "index_attendances_on_shop_id", using: :btree
  add_index "attendances", ["staff_id"], name: "index_attendances_on_staff_id", using: :btree

  create_table "color_schemes", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.integer  "position",        limit: 4
    t.boolean  "is_public",                     default: false
    t.string   "repository_path", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "alt_id",      limit: 255
    t.string   "name",        limit: 255
    t.string   "postal",      limit: 255
    t.string   "address_1",   limit: 255
    t.string   "address_2",   limit: 255
    t.string   "telephone_1", limit: 255
    t.string   "telephone_2", limit: 255
    t.string   "fax",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_bags", force: :cascade do |t|
    t.integer  "shop_id",             limit: 4
    t.integer  "parent_id",           limit: 4
    t.integer  "position",            limit: 4
    t.string   "hash_key",            limit: 255
    t.integer  "content_type",        limit: 4
    t.integer  "content_category_id", limit: 4
    t.integer  "web_page_id",         limit: 4
    t.string   "name",                limit: 255
    t.text     "description",         limit: 65535
    t.boolean  "is_public",                         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_categories", force: :cascade do |t|
    t.integer  "shop_id",         limit: 4
    t.integer  "parent_id",       limit: 4
    t.integer  "position",        limit: 4
    t.integer  "category_type",   limit: 4
    t.integer  "web_page_id",     limit: 4
    t.string   "title",           limit: 255
    t.text     "description",     limit: 65535
    t.text     "description_2",   limit: 65535
    t.text     "description_3",   limit: 65535
    t.integer  "integer_field",   limit: 4
    t.integer  "integer_field_2", limit: 4
    t.integer  "integer_field_3", limit: 4
    t.boolean  "is_public",                     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_leafs", force: :cascade do |t|
    t.integer  "shop_id",             limit: 4
    t.integer  "content_bag_id",      limit: 4
    t.integer  "content_category_id", limit: 4
    t.integer  "staff_id",            limit: 4
    t.string   "hash_key",            limit: 255
    t.integer  "position",            limit: 4
    t.string   "title",               limit: 255
    t.text     "description",         limit: 65535
    t.text     "description_2",       limit: 65535
    t.text     "description_3",       limit: 65535
    t.integer  "integer_field",       limit: 4
    t.integer  "integer_field_2",     limit: 4
    t.integer  "integer_field_3",     limit: 4
    t.string   "link_title",          limit: 255
    t.text     "link_url",            limit: 65535
    t.boolean  "is_open_new",                       default: false
    t.string   "link_title_2",        limit: 255
    t.text     "link_url_2",          limit: 65535
    t.boolean  "is_open_new_2",                     default: false
    t.string   "link_title_3",        limit: 255
    t.text     "link_url_3",          limit: 65535
    t.boolean  "is_open_new_3",                     default: false
    t.boolean  "is_public",                         default: false
    t.date     "publish_from"
    t.date     "publish_until"
    t.boolean  "is_hot",                            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "company_id",  limit: 4
    t.integer  "shop_id",     limit: 4
    t.string   "alt_id",      limit: 255
    t.string   "name",        limit: 255
    t.string   "furigana",    limit: 255
    t.string   "email",       limit: 255
    t.string   "telephone",   limit: 255
    t.string   "telephone_2", limit: 255
    t.string   "postal_code", limit: 255
    t.text     "address",     limit: 65535
    t.text     "address_2",   limit: 65535
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["alt_id"], name: "index_customers_on_alt_id", using: :btree
  add_index "customers", ["birthday"], name: "index_customers_on_birthday", using: :btree
  add_index "customers", ["company_id"], name: "index_customers_on_company_id", using: :btree
  add_index "customers", ["shop_id"], name: "index_customers_on_shop_id", using: :btree

  create_table "layout_schemes", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.integer  "position",        limit: 4
    t.boolean  "is_public",                     default: false
    t.string   "repository_path", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "shop_id",    limit: 4
    t.text     "image",      limit: 65535
    t.text     "info",       limit: 65535
    t.integer  "position",   limit: 4
    t.integer  "ref_id",     limit: 4
    t.string   "ref_type",   limit: 255
    t.integer  "my_size",    limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["ref_id", "ref_type"], name: "index_photos_on_ref_id_and_ref_type", using: :btree
  add_index "photos", ["shop_id"], name: "index_photos_on_shop_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "customer_id",    limit: 4
    t.integer  "shop_id",        limit: 4
    t.integer  "staff_id",       limit: 4
    t.datetime "reserved_on"
    t.datetime "reserved_until"
    t.integer  "min_period",     limit: 4
    t.text     "memo_1",         limit: 65535
    t.text     "memo_2",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations", ["customer_id"], name: "index_reservations_on_customer_id", using: :btree
  add_index "reservations", ["shop_id"], name: "index_reservations_on_shop_id", using: :btree

  create_table "roster_labels", force: :cascade do |t|
    t.integer  "shop_id",    limit: 4
    t.string   "name",       limit: 255
    t.integer  "start_hour", limit: 4
    t.integer  "until_hour", limit: 4
    t.integer  "position",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shops", force: :cascade do |t|
    t.integer  "company_id",                        limit: 4
    t.integer  "position",                          limit: 4
    t.integer  "parent_id",                         limit: 4
    t.string   "alt_id",                            limit: 255
    t.string   "name",                              limit: 255
    t.string   "postal",                            limit: 255
    t.string   "address_1",                         limit: 255
    t.string   "address_2",                         limit: 255
    t.string   "telephone_1",                       limit: 255
    t.string   "telephone_2",                       limit: 255
    t.string   "fax",                               limit: 255
    t.integer  "business_hour_from",                limit: 4,     default: 9
    t.integer  "business_hour_until",               limit: 4,     default: 21
    t.float    "lat",                               limit: 24
    t.float    "lng",                               limit: 24
    t.boolean  "option_attendance_management",                    default: false
    t.boolean  "option_customer_management",                      default: false
    t.boolean  "option_reservation_management",                   default: false
    t.boolean  "option_sales_management",                         default: false
    t.integer  "room_size_mb",                      limit: 4
    t.integer  "wsite_run_mode",                    limit: 4,     default: 10
    t.string   "wsite_hash_key",                    limit: 255
    t.integer  "wsite_color_deploy_id",             limit: 4
    t.integer  "wsite_layout_deploy_id",            limit: 4
    t.integer  "wsite_color_edit_id",               limit: 4
    t.integer  "wsite_layout_edit_id",              limit: 4
    t.string   "wsite_layout_pc_specific_basename", limit: 255
    t.string   "wsite_keywords",                    limit: 255
    t.string   "wsite_description_shop",            limit: 255
    t.string   "wsite_description_business",        limit: 255
    t.string   "wsite_telephone",                   limit: 255
    t.string   "wsite_email",                       limit: 255
    t.string   "social_facebook_uri",               limit: 255
    t.string   "social_gplus_uri",                  limit: 255
    t.string   "social_twitter_uri",                limit: 255
    t.string   "social_blogger_uri",                limit: 255
    t.string   "social_pinterest_uri",              limit: 255
    t.string   "social_tumblr_uri",                 limit: 255
    t.string   "google_calendar_url",               limit: 255
    t.text     "google_calendar_emb_frame_code",    limit: 65535
    t.string   "wsite_ga_code",                     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "use_disqus",                                      default: false
    t.text     "disqus_code",                       limit: 65535
    t.text     "analytics_code",                    limit: 65535
    t.text     "custom_metas",                      limit: 65535
    t.string   "copyright_notice",                  limit: 255
    t.string   "social_instagram_uri",              limit: 255
  end

  add_index "shops", ["wsite_hash_key"], name: "index_shops_on_wsite_hash_key", using: :btree

  create_table "staffs", force: :cascade do |t|
    t.integer  "shop_id",              limit: 4
    t.integer  "position",             limit: 4
    t.string   "alt_id",               limit: 255
    t.string   "name",                 limit: 255
    t.string   "job_title",            limit: 255
    t.text     "description",          limit: 65535
    t.integer  "staff_status",         limit: 4,     default: 100
    t.string   "social_facebook_uri",  limit: 255
    t.string   "social_gplus_uri",     limit: 255
    t.string   "social_twitter_uri",   limit: 255
    t.string   "social_blogger_uri",   limit: 255
    t.string   "social_pinterest_uri", limit: 255
    t.string   "social_tumblr_uri",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "social_instagram_uri", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",                     limit: 40
    t.string   "name",                      limit: 100, default: ""
    t.string   "email",                     limit: 100
    t.string   "encrypted_password",        limit: 128, default: "", null: false
    t.string   "password_salt",             limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
    t.integer  "role",                      limit: 4,   default: 5
    t.integer  "company_id",                limit: 4
    t.integer  "shop_id",                   limit: 4
    t.integer  "try_count",                 limit: 4,   default: 0
    t.datetime "confirmation_sent_at"
    t.datetime "remember_created_at"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

  create_table "visual_widget_bags", force: :cascade do |t|
    t.integer  "shop_id",          limit: 4
    t.integer  "visual_widget_id", limit: 4
    t.string   "data_string",      limit: 255
    t.text     "data_text",        limit: 65535
    t.string   "data_url",         limit: 255
    t.boolean  "data_boolean",                   default: false
    t.text     "data_code",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visual_widget_bags", ["shop_id"], name: "index_visual_widget_bags_on_shop_id", using: :btree
  add_index "visual_widget_bags", ["visual_widget_id"], name: "index_visual_widget_bags_on_visual_widget_id", using: :btree

  create_table "visual_widgets", force: :cascade do |t|
    t.integer  "layout_scheme_id", limit: 4
    t.string   "hash_key",         limit: 255
    t.integer  "position",         limit: 4
    t.integer  "widget_type",      limit: 4,   default: 10
    t.string   "title",            limit: 255
    t.string   "description",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visual_widgets", ["hash_key"], name: "index_visual_widgets_on_hash_key", using: :btree
  add_index "visual_widgets", ["layout_scheme_id"], name: "index_visual_widgets_on_layout_scheme_id", using: :btree

  create_table "web_pages", force: :cascade do |t|
    t.integer  "shop_id",         limit: 4
    t.integer  "parent_id",       limit: 4
    t.integer  "position",        limit: 4
    t.integer  "content_type",    limit: 4
    t.integer  "page_type",       limit: 4
    t.integer  "template_name",   limit: 4
    t.string   "controller_name", limit: 255,   default: "bs_renderer"
    t.string   "action_name",     limit: 255
    t.string   "content_key",     limit: 255
    t.string   "name",            limit: 255
    t.boolean  "is_public",                     default: true
    t.string   "external_url",    limit: 255
    t.boolean  "is_open_new",                   default: false
    t.text     "frame_code",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
