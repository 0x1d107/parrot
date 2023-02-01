DROP TABLE IF EXISTS topics;
CREATE VIRTUAL TABLE topics using fts4(hash,title);
.mode csv
.import topics.csv topics
