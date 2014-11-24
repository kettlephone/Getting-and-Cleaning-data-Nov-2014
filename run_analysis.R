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



#read in the "test" data and insert into a data frame
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

## load the training data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

#read in the test subjects and insert into a data frame
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
## creates a dataframe containing the training subjects
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt") 

#read in the feature and activity labels
feature_labels <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

## create a vector of the test activities from the y-test data frame, using
## factor() to change the levels from numerical to readable text
test_activities <-  factor(y_test[,1], levels = c(1:6), labels = activity_labels[,2])

## create a vector of the training activities from the test data frome
train_activities <- factor(y_train[,1], levels = c(1:6), labels = activity_labels[,2])

## create an index of the relevant data fields, (standard deviations and means)
## the second column will be indexed via the grep command
## for each string.  The resulting vectors are concactenated and then sorted
ms_index <- sort(c(grep("mean", feature_labels[,2]),grep("std", feature_labels[,2])))

## subset the x_train and x_test data sets by the relevant indexs (assignment req #2)
x_train <- x_train[,ms_index]
x_test <- x_test[,ms_index]

## append the relevant feature labels to the column names (assinment req #4)
ms_labels <- feature_labels[ms_index,2]
colnames(x_train) <- ms_labels
colnames(x_test) <- ms_labels


## append the vecotr of activities to the front of the data frames
#  and rename the column in both data frames to "Activity" (assignment req #3)
x_test <- cbind(test_activities, x_test)
x_train <- cbind(train_activities,x_train)
names(x_test)[names(x_test)=="test_activities"] <- "Activity"
names(x_train)[names(x_train)=="train_activities"] <- "Activity"

## append the subjects to the data frames
## and rename the column in both data frames to "Subject"
x_test <- cbind(test_subjects[,1],x_test)
x_train <- cbind(train_subjects[,1],x_train)
names(x_test)[names(x_test)=="test_subjects[, 1]"] <- "Subjects"
names(x_train)[names(x_train)=="train_subjects[, 1]"] <- "Subjects"

## merge the data frames and order by subject and then by activity (Assignment req #1)
Combined <- rbind(x_test,x_train)
Combined <- Combined[order(Combined$Subjects,Combined$Activity),]

## find the means of all the data columns
## Using the aggregate function, the means of each subject as they performed each activity will be 
## determined and returned in a data frame. The data frome returned is (in the test case of the 
## assingment) 180 x 81.  This corresponds to 30 subjects, with 

Analyzed <- aggregate(Combined[,3:81],  by = Combined[c("Subjects", "Activity")], FUN = mean)
write.table(Analyzed, file = "Analyzed.txt", row.names = FALSE)
