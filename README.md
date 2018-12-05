# coursera: Getting & Cleanning_data
Coursera: Getting &amp; Cleaning data. Course project

In this project we read tidy data about some experiment results in Samsung Galaxy S smartphones.
Input data are two sets of data: test data and train data. They have information about subject, activity and a lot of variables (561) for each one (test/train). There are also  some files that are unique for both: information about the variables in the test/train files, and information about de activities: name

The steps in this script (run_analysis.R) are:

Read features.txt, in order to know all the variables in the test/train data files. Check wich of them represent mean or standar deviation.
Read group (test(train) files: ++ Read Subjet info ++ read activity info ++ read data file ++ select only de variables we are interested in (mean / std) ++ combine those tables to get the group data set
Union both data sets (test + train)
Read activity info and join it with the data set to get activity names
Group the observations by activity and subject_id, and summarize to get mean of every variable in our dataset

The result is exported to a datafile named "gett_clean_data_RES.txt". The structure and contents of this file is documented in CodeBook.txt file.
