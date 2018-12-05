# coursera: Getting & Cleanning_data
Processing tidy data from Samsung Galaxy S smartphones features observations

In this project we read tidy data about experiment results in Samsung Galaxy S smartphones.
Input data are two sets of data: test data and train data. They have information about subject, activity and a lot of variables (561) for each one (test/train). There are also  some files that are unique for both: information about the variables in the test/train files, and information about de activities: name

The steps in this script (run_analysis.R) are:

Read features.txt, in order to know all the variables in the test/train data files. Check wich of them represent mean or standar deviation.
Read and combine test (/train) data files in order to get all the information clean and together, and considering only variables about mean or stantard deviation. 
Union both data sets (test + train)
Read activity info and join it with the data set to get activity names
Group the observations by activity and subject, and summarize to get mean of every variable in our dataset.

The result is exported to a datafile named "gett_clean_data_RES.txt". The structure and contents of this file is documented in CodeBook.txt file.
