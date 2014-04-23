RCodes
======

This repository consists of R Code Snippets developed by me

Here is a description of various snippets available
1. run_analysis.R

Description:
 -> This script processes the data for observations on test and training front provided as part of the data cleansing assignment.

Pre-requisites:
 -> It is assumed that files are present in the following locations
 -> YourBaseFolder: This is the folder where following files and R script is placed. Do a SETWD() before executing the script
 -> YourBaseFolder\\features.txt : This is feature description file
 -> YourBaseFolder\\activity_labels.txt : This is activity description file
 -> YourBaseFolder\\X_test.txt : This is test file for variable data
 -> YourBaseFolder\\y_test.txt : This is test file with activity data
 -> YourBaseFolder\\subject_test.txt : This is test file for subject data
 -> YourBaseFolder\\X_train.txt : This is training file for variable data
 -> YourBaseFolder\\y_train.txt : This is training file with activity data
 -> YourBaseFolder\\subject_train.txt : This is training file for subject data
 -> The script uses sqldf package. Please ensure that the same is installed and available for execution.
 -> The R version on which the script is based and tested is 3.1.
 -> The size of the files being huge, ensure that sufficient memory (>=691 MB (max) based on gc() output) is available.

Output:
It produces following datasets of relevance.
 -> ftestx: This is a dataset containing all the test data combined
 -> ftrainx: This is a dataset containing all the training data combined
 -> fcombined: This is a dataset containing the data combined for test as well as training observations
 -> fstdmean: This dataset consists of data only for std deviation and mean variables as requested in the assignment
 -> dstmeanframe: This is a dataset containing average of all std deviation and mean observations for a given subject and activity
