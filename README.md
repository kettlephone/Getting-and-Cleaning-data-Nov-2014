Getting-and-Cleaning-data-Nov-2014
==================================

Repo for Coursera Getting and cleaning data class running in Nov 2014

This script will take the Samsung data. 
Below is the comment header from the script:
## run_analysis
## file UCI HAR Dataset must be unzipped in the working directory
## file structure should not be modified
## this script will perform the following operations
## 1. Read in the data from seperate data files
## 2.  Format the test and train data seperately, making two identical
##    formated data frames per the specifications (means and standard deviations only)
## 3. Join the data frames
## 4. Summarize and subset as required per the specification
## Returns a data frame called "Combined" which meets the requirements 1-4 of 
## the assignment
## Creates a data frame called "Analyzed" which meets requirement 5 of the 
## assignment
## Outputs a space delimited text file "Analyzed.txt

In addition:

Means and standard deviations were sorted by using the grep() function in R
with the strings "mean" and "std".  This yielded 79 columns from the data set 
provided with the course.

Data is imported with the Samsung data labels for the values.
The activites have been converted into factors based on the following table:
 
	1	WALKING
	2	WALKING_UPSTAIRS
	3	WALKING_DOWNSTAIRS
  4	SITTING
  5	STANDING
  6	LAYING

Subjects remain numbered from 1-30

The features columns have been named accourding to the file UCI HAR Dataset/features.txt
