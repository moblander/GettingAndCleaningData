Course Project
--------------

The course project makes use of a 'Human Activity Recognition Using Smartphones' data set. To create the data set, 30 subjects each performed six activities. Subjects were divided into two groups: a training group and a testing group. As each subject performed an activity, measurements were taken in groups. Each group consisted of 128 measurements (of multiple variables) taken in succession separated by 0.02 seconds. Multiple groups of measurements were taken for each combination of subject and activity. Each group of 128 measurements was used to calculate a 561-feature vector. 

So, each row (corresponding to a particular subject performing a particular activity) in the testing and training data sets contains values from 561 different variables, each derived from the same measurement group. 10,299 of these groups of measurements were taken for the 180 combinations of 30 subjects and 6 activities. Of the 561 variables derived from each of these measurement groups, the run_analysis.R file keeps only the 66 variables whose values themselves were calculated as a mean or standard deviation.

The run_analysis.R file combines the training and testing data sets into a single data set, groups the data by combination of subject and activity, and calculates the mean (for each combination of subject and activity) of each of the 66 variables whose values themselves were calculated as a mean or standard deviation.

### How to use the run_analysis.R file:

1. Download the source data to your local machine: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Extract the contents of the zip file into a 'UCI Har Dataset' folder
3. Place the run_analysis.R file in the 'UCI Har Dataset' folder
4. Set your R working directory to the 'UCI Har Dataset' folder
5. Source the contents of the run_analysis.R file
6. Execute the run_analysis() function

### What the run_analysis.R file does:

1. Merges the training and test data sets into a single dataset
2. Extracts only the measurements on mean and standard deviation
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. Calculates the mean for each variable, grouped by subject and activity
6. Writes the resulting data set to a text file in the 'UCI Har Dataset' folder
