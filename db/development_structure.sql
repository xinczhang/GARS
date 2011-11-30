CREATE TABLE `application_reviews` (
  `application_id` int(11) DEFAULT NULL,
  `review_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apply_yourself_id` int(11) DEFAULT NULL,
  `official_test_score_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `apply_yourselves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submittedDate` datetime DEFAULT NULL,
  `applicantClientID` int(11) DEFAULT NULL,
  `applicantLastName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `applicantFirstName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `applicantMiddleName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `dateOfBirth` datetime DEFAULT NULL,
  `countryOfCitizenship` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ethnicity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `race` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permanentResident` int(11) DEFAULT NULL,
  `currentPhone` int(11) DEFAULT NULL,
  `emailAddress` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `applicationType` int(11) DEFAULT NULL,
  `verbal` int(11) DEFAULT NULL,
  `verbalPercentile` int(11) DEFAULT NULL,
  `quantitative` int(11) DEFAULT NULL,
  `quantitativePercentile` int(11) DEFAULT NULL,
  `analytical` int(11) DEFAULT NULL,
  `analyticalPercentile` int(11) DEFAULT NULL,
  `subjectTestTaken` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subjectScore` int(11) DEFAULT NULL,
  `tse` int(11) DEFAULT NULL,
  `ielts` float DEFAULT NULL,
  `toeflTotal` int(11) DEFAULT NULL,
  `toeflReading` int(11) DEFAULT NULL,
  `toeflSpeaking` int(11) DEFAULT NULL,
  `toeflWriting` int(11) DEFAULT NULL,
  `toeflListening` int(11) DEFAULT NULL,
  `toeflInternet` int(11) DEFAULT NULL,
  `program` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `indicatedTopics` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `undergradRank` int(11) DEFAULT NULL,
  `undergradOutOf` int(11) DEFAULT NULL,
  `gradRank` int(11) DEFAULT NULL,
  `gradOutOf` int(11) DEFAULT NULL,
  `institution1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `undergradGPA` float DEFAULT NULL,
  `gradingScale1` float DEFAULT NULL,
  `year1GPA` float DEFAULT NULL,
  `year2GPA` float DEFAULT NULL,
  `year3GPA` float DEFAULT NULL,
  `year4GPA` float DEFAULT NULL,
  `year5GPA` float DEFAULT NULL,
  `institution2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gradGPA` float DEFAULT NULL,
  `year6GPA` float DEFAULT NULL,
  `year7GPA` float DEFAULT NULL,
  `courseTitle1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gradOrUndergrad1` int(11) DEFAULT NULL,
  `instructor1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `yearsTaken1` int(11) DEFAULT NULL,
  `grade1` float DEFAULT NULL,
  `usbEquivalent1` float DEFAULT NULL,
  `courseTitle2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gradOrUndergrad2` int(11) DEFAULT NULL,
  `instructor2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `yearsTaken2` int(11) DEFAULT NULL,
  `gradingScale2` float DEFAULT NULL,
  `grade2` float DEFAULT NULL,
  `usbEquivalent2` float DEFAULT NULL,
  `couseTitle3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gradOrUndergrad3` int(11) DEFAULT NULL,
  `instructor3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `yearsTaken3` int(11) DEFAULT NULL,
  `gradingScale3` float DEFAULT NULL,
  `grade3` float DEFAULT NULL,
  `usbEquivalent3` float DEFAULT NULL,
  `courseTitle4` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gradOrUndergrad4` int(11) DEFAULT NULL,
  `instructor4` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `yearsTaken4` int(11) DEFAULT NULL,
  `gradingScale4` float DEFAULT NULL,
  `grade4` float DEFAULT NULL,
  `usbEquivalent4` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `official_test_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicantLastName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applicantFirstName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `countryOfCitizenship` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateOfBirth` datetime NOT NULL,
  `gender` int(11) NOT NULL,
  `verbal` int(11) NOT NULL,
  `verbalPercentile` int(11) NOT NULL,
  `quantitative` int(11) NOT NULL,
  `quantitativePercentile` int(11) NOT NULL,
  `analytical` int(11) NOT NULL,
  `analyticalPercentile` int(11) NOT NULL,
  `subject` int(11) NOT NULL,
  `subjectPercentile` int(11) NOT NULL,
  `subjectName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `toeflTotal` int(11) NOT NULL,
  `toeflReading` int(11) NOT NULL,
  `toeflSpeaking` int(11) NOT NULL,
  `toeflWriting` int(11) NOT NULL,
  `toeflListening` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `errorMsg` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=980190963 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `research_areas` (
  `code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `index_research_areas_on_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `research_areas_users` (
  `user_id` int(11) DEFAULT NULL,
  `research_area_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `review` text COLLATE utf8_unicode_ci NOT NULL,
  `rating` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=980190963 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `rounds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=980190963 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sex` int(11) NOT NULL,
  `role` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20111026050647');

INSERT INTO schema_migrations (version) VALUES ('20111026051733');

INSERT INTO schema_migrations (version) VALUES ('20111026052918');

INSERT INTO schema_migrations (version) VALUES ('20111026054034');

INSERT INTO schema_migrations (version) VALUES ('20111026061634');

INSERT INTO schema_migrations (version) VALUES ('20111026065025');

INSERT INTO schema_migrations (version) VALUES ('20111026065316');

INSERT INTO schema_migrations (version) VALUES ('20111026065944');

INSERT INTO schema_migrations (version) VALUES ('20111026073946');

INSERT INTO schema_migrations (version) VALUES ('20111026080635');

INSERT INTO schema_migrations (version) VALUES ('20111026080719');

INSERT INTO schema_migrations (version) VALUES ('20111026080880');

INSERT INTO schema_migrations (version) VALUES ('20111026080881');

INSERT INTO schema_migrations (version) VALUES ('20111026080882');

INSERT INTO schema_migrations (version) VALUES ('20111026080883');

INSERT INTO schema_migrations (version) VALUES ('20111026080888');
