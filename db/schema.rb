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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111207045547) do

  create_table "application_reviews", :id => false, :force => true do |t|
    t.integer "application_id"
    t.integer "review_id"
    t.integer "user_id"
  end

  create_table "applications", :force => true do |t|
    t.integer  "apply_yourself_id"
    t.integer  "official_test_score_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pdf_submitted",          :default => 0
    t.integer  "assigned",               :default => 0
    t.integer  "status",                 :default => 0
    t.string   "program",                :default => "master"
  end

  create_table "apply_yourselves", :force => true do |t|
    t.datetime "submission_date"
    t.integer  "applicant_client_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.integer  "gender"
    t.integer  "birth_month"
    t.integer  "birth_day"
    t.integer  "birth_year"
    t.string   "citizenship"
    t.string   "ethnicity"
    t.string   "race"
    t.integer  "permanent_resident"
    t.integer  "phone"
    t.string   "email_address"
    t.string   "specialization"
    t.integer  "GRE_V"
    t.integer  "GRE_V_pctile"
    t.integer  "GRE_Q"
    t.integer  "GRE_Q_pctile"
    t.integer  "GRE_A"
    t.integer  "GRE_A_pctile"
    t.string   "GRE_subj_name"
    t.integer  "GRE_subj_score"
    t.integer  "TOEFL"
    t.float    "IELTS"
    t.integer  "TOEFL_internet"
    t.string   "research_area"
    t.string   "research_topics"
    t.integer  "ug_rank"
    t.integer  "ug_out_of"
    t.integer  "grad_rank"
    t.integer  "grad_out_of"
    t.string   "ug_inst"
    t.float    "ug_GPA"
    t.float    "ug_scale"
    t.float    "ug_GPA1"
    t.float    "ug_GPA2"
    t.float    "ug_GPA3"
    t.float    "ug_GPA4"
    t.float    "ug_GPA5"
    t.string   "grad_inst"
    t.float    "grad_GPA"
    t.integer  "grad_scale"
    t.float    "grad_GPA1"
    t.float    "grad_GPA2"
    t.string   "theory_course_title"
    t.integer  "theory_scale"
    t.float    "theory_grade"
    t.float    "theory_SBU_equiv"
    t.string   "algorithm_course_title"
    t.float    "algorithm_scale"
    t.float    "algorithm_grade"
    t.float    "algorithm_SBU_equiv"
    t.string   "prog_lang_course_title"
    t.float    "prog_lang_scale"
    t.float    "prog_lang_grade"
    t.float    "prog_lang_SBU_equiv"
    t.string   "os_course_title"
    t.float    "os_scale"
    t.float    "os_grade"
    t.float    "os_SBU_equiv"
    t.string   "otherInfo"
  end

  create_table "official_test_scores", :force => true do |t|
    t.string  "last_name"
    t.string  "first_name"
    t.string  "email_address"
    t.string  "citizenship"
    t.integer "birth_month"
    t.integer "birth_day"
    t.integer "birth_year"
    t.integer "gender"
    t.integer "ofcl_GRE_V"
    t.integer "ofcl_GRE_V_pctile"
    t.integer "ofcl_GRE_Q"
    t.integer "ofcl_GRE_Q_pctile"
    t.integer "ofcl_GRE_A"
    t.integer "ofcl_GRE_A_pctile"
    t.integer "ofcl_GRE_subj"
    t.integer "ofcl_GRE_subj_pctile"
    t.string  "ofcl_GRE_subj_name"
    t.integer "ofcl_TOEFL_total"
    t.integer "ofcl_TOEFL_listen"
    t.integer "ofcl_TOEFL_read"
    t.integer "ofcl_TOEFL_speak"
    t.integer "ofcl_TOEFL_write"
    t.string  "otherInfo"
  end

  create_table "reports", :force => true do |t|
    t.string   "filename",   :limit => 20, :null => false
    t.integer  "status",                   :null => false
    t.text     "errorMsg",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "research_areas", :id => false, :force => true do |t|
    t.string "code", :limit => 10, :null => false
    t.string "name",               :null => false
  end

  add_index "research_areas", ["code"], :name => "index_research_areas_on_code", :unique => true

  create_table "research_areas_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.string  "research_area_id", :limit => 10, :null => false
  end

  create_table "reviews", :force => true do |t|
    t.text     "review",                   :null => false
    t.integer  "rating",                   :null => false
    t.datetime "timestamp",                :null => false
    t.integer  "submitted", :default => 0
  end

  create_table "rounds", :force => true do |t|
    t.datetime "startTime"
    t.datetime "endTime"
  end

  create_table "users", :force => true do |t|
    t.string   "name",       :limit => 20,                  :null => false
    t.string   "email",                                     :null => false
    t.string   "password",                                  :null => false
    t.integer  "sex",                                       :null => false
    t.integer  "role",                                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.float    "workload",                 :default => 1.0
  end

end
