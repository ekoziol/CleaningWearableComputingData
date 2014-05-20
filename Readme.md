### Readme.md

## Purpose
The purpose of this assignment was to accomplish the following:

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The following data was used and his been included in the data folder:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

which was taken from:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

courtesy of:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Methodology
The first part of the assignment calls for a merging of the training and test sets.  This merging could be useful for re-randominzing the data for machine learning techniques using monte carlo methods to ensure that the predictive models hold true and are not a mishap of data.  The merging was performed by importing X_train, X_test, y_train and y_test in as separate data frames in R.  Each similar data set (X, y) had their respective train and test sets combined using the rbind() command which appended the test set to the end of the training set.  The resulting data frames were named x_combined and y_combined.

After the training and test sets had been combined, the features list and activity labels were imported into R data frames as well.  The features list was stripped of all punctution using the gsub() command with a regex applied using the sapply() method.  Once column labels that would not be problematic for R were established, the names() vector for the x_combined data frame was over-written with punctuation free features list.  Then the sapply() command was used to apply the grep() command to the features list to find all feature names containing either mean or std (for the requested mean and std for each measurement).  This list was then used to filter the x_combined data frame into a new data frame called x_combinedSelected, which contains only the columns for measurements with mean or std in the label name.  Next, the activity labels were merged with the y_combined data frame and filtered into a new data frame called y_combinedNamed.  The y_combinedNamed data frame was left in an un sorted order so that the x features would match up with the y activities for proper machine learning techniques in the future.
