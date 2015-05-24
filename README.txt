
README.txt
Getting and Cleaning Data - Course Project

The goal of this README is to simply and clearly state how this projects meets the three main requirements which include creating:
1. README.txt
2. A tidy dataset meeting the tidy data principles of week 1 which are:
-- each variable measured should be in one column
-- each different observation of that variable should be in a different row
3. Data Dictionary know as Code Book

The dataset includes the following files:
=========================================

- 'README.txt'

- 'CodeBook.txt':  Variable name reference and descriptions

- 'dataset.txt': The data set of Subject, Activity, and Observation Variables.  The observation varilable is the mean of all observations taken for a given subject and activity. 

CODE FOR RUNNING ANALYSIS AND GENERATING DATA FROM R
====================================================
source("run_analysis.R")
runAnalysis()

CODE FOR READING DATA SET BACK INTO R
=====================================
data <- read.table("dataset.txt", header = TRUE)
View(data)

Note: assumption that dataset.txt is in the same directory as UCI HAR Dataset and is set as current working directory

Other Notes: 
============
- Features are normalized and bounded within [-1,1]
- These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz
- Filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise
- Acceleration signal was separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using a low pass Butterworth filter with a corner frequency of 0.3 Hz
- NA values are left in the dataset to indicate partially identified data elements and provide sense of the originating data quality.  The user may want to remove these from the final data set for usage in further analysis.

