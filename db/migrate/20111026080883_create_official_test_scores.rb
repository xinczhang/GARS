class CreateOfficialTestScores < ActiveRecord::Migration
  def change
    create_table :official_test_scores, :force=>true do |t|	
    t.string   "applicantLastName",                   :null => false
    t.string   "applicantFirstName",                  :null => false
    t.string   "key",                                 :null => false
    t.string   "countryOfCitizenship",                :null => false
    t.datetime "dateOfBirth",                         :null => false
    t.integer   "gender",                 	      :null => false
    t.integer  "verbal",                              :null => false
    t.integer  "verbalPercentile",                    :null => false
    t.integer  "quantitative",                        :null => false
    t.integer  "quantitativePercentile",              :null => false
    t.integer  "analytical",                          :null => false
    t.integer  "analyticalPercentile",                :null => false
    t.integer  "subject",                             :null => false
    t.integer  "subjectPercentile",                   :null => false
    t.string   "subjectName",                         :null => false
    t.integer  "toeflTotal",                          :null => false
    t.integer  "toeflReading",                        :null => false
    t.integer  "toeflSpeaking",                       :null => false
    t.integer  "toeflWriting",                        :null => false
    t.integer  "toeflListening",                      :null => false
    end
  end
end
