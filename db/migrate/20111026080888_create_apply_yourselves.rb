class CreateApplyYourselves < ActiveRecord::Migration
  def change
    create_table :apply_yourselves, :force=>true do |t|
    t.datetime "submittedDate",                       :null => true
    t.integer  "applicantClientID",                   :null => true
    t.string   "applicantLastName",                   :null => true
    t.string   "applicantFirstName",                  :null => true
    t.string   "applicantMiddleName",                 :null => true
    t.integer  "gender",                 	      :null => true
    t.datetime "dateOfBirth",                         :null => true
    t.string   "countryOfCitizenship",                :null => true
    t.string   "ethnicity",                           :null => true
    t.string   "race",                                :null => true
    t.integer  "permanentResident",      	      :null => true
    t.integer  "currentPhone",                        :null => true
    t.string   "emailAddress",                        :null => true
    t.integer  "applicationType",        	      :null => true
    t.integer  "verbal",                              :null => true
    t.integer  "verbalPercentile",                    :null => true
    t.integer  "quantitative",                        :null => true
    t.integer  "quantitativePercentile",              :null => true
    t.integer  "analytical",                          :null => true
    t.integer  "analyticalPercentile",                :null => true
    t.string   "subjectTestTaken",                    :null => true
    t.integer  "subjectScore",                        :null => true
    t.integer  "tse",                                 :null => true
    t.float    "ielts",                               :null => true
    t.integer  "toeflTotal",                          :null => true
    t.integer  "toeflReading",                        :null => true
    t.integer  "toeflSpeaking",                       :null => true
    t.integer  "toeflWriting",                        :null => true
    t.integer  "toeflListening",                      :null => true
    t.integer  "toeflInternet",                       :null => true
    t.string   "program",                             :null => true
    t.string   "indicatedTopics",                     :null => true
    t.integer  "undergradRank",                       :null => true
    t.integer  "undergradOutOf",                      :null => true
    t.integer  "gradRank",                            :null => true
    t.integer  "gradOutOf",                           :null => true
    t.string   "institution1",                        :null => true
    t.float    "undergradGPA",                        :null => true
    t.float    "gradingScale1",                       :null => true
    t.float    "year1GPA",                            :null => true
    t.float    "year2GPA",                            :null => true
    t.float    "year3GPA",                            :null => true
    t.float    "year4GPA",                            :null => true
    t.float    "year5GPA",                            :null => true
    t.string   "institution2",                        :null => true
    t.float    "gradGPA",                             :null => true
    t.float    "year6GPA",                            :null => true
    t.float    "year7GPA",                            :null => true
    t.string   "courseTitle1",                         :null => true
    t.integer  "gradOrUndergrad1",       	      :null => true
    t.string   "instructor1",                         :null => true
    t.integer  "yearsTaken1",                         :null => true
    t.float    "grade1",                              :null => true
    t.float    "usbEquivalent1",                      :null => true
    t.string   "courseTitle2",                         :null => true
    t.integer  "gradOrUndergrad2",                    :null => true
    t.string   "instructor2",                         :null => true
    t.integer  "yearsTaken2",                         :null => true
    t.float    "gradingScale2",                       :null => true
    t.float    "grade2",                              :null => true
    t.float    "usbEquivalent2",                      :null => true
    t.string   "couseTitle3",                         :null => true
    t.integer  "gradOrUndergrad3",                    :null => true
    t.string   "instructor3",                         :null => true
    t.integer  "yearsTaken3",                         :null => true
    t.float    "gradingScale3",                       :null => true
    t.float    "grade3",                              :null => true
    t.float    "usbEquivalent3",                      :null => true
    t.string   "courseTitle4"		      
    t.integer  "gradOrUndergrad4"
    t.string   "instructor4"
    t.integer  "yearsTaken4"
    t.float    "gradingScale4"
    t.float    "grade4"
    t.float    "usbEquivalent4"
    end
  end
end
