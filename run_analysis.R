run_analysis <- function() {
     
     # 1. Merge the training and test sets to create one data set:
     
          train <- read.table("train/X_train.txt")
          test <- read.table("test/X_test.txt")
          
          data <- rbind(train, test)
     
     # 2. Extract only the measurements on mean and standard deviation:
     
          features <- read.table("features.txt", stringsAsFactors=F)[,2]
          
          # Create a vector of indices corresponding to features that contain "mean()" or "std()"
          features.indices_to_keep <- grep("mean\\(\\)|std\\(\\)", features)
     
          # Keep only the features that contain "mean()" or "std()"
          features <- features[features.indices_to_keep]
     
          # Remove parenthesis (cosmetic preference)
          features <- gsub("\\(|\\)", "", features)
          
          # Keep only the data measurements on mean and standard deviation
          data <- subset(data, select=features.indices_to_keep)
     
     # 3. Use descriptive activity names to name the activities in the data set:
     
          activity.labels <- read.table("activity_labels.txt", stringsAsFactors=F)
          train.activity <- read.table("train/y_train.txt", stringsAsFactors=F)[,1]
          test.activity <- read.table("test/y_test.txt", stringsAsFactors=F)[,1]
          
          # Merge the training.activity and test.activity vectors
          activity <- append(train.activity, test.activity)
          
          # Replace the activity ids with the labels
          activity <- activity.labels[match(activity, activity.labels[[1]]),2]
     
     # 4. Appropriately label the data set with descriptive variable names:
     
          colnames(data) <- features
     
     # 5. Create a data set with the average of each variable for each activity and each subject:
     
          train.subject <- read.table("train/subject_train.txt", stringsAsFactors=F)[,1]
          test.subject <- read.table("test/subject_test.txt", stringsAsFactors=F)[,1]
          
          # Merge the training.subject and test.subject vectors
          subject <- append(train.subject, test.subject)
     
          data <- cbind(subject, activity, data, stringsAsFactors=F)
     
          # Split the data into a list of 30 data frames (one for each subject)
          data <- split(data, data$subject)
          
          # Split each of the 30 data frames into a list of 6 data frames (one for each activity)
          data <- lapply(data, function(x){split(x, x$activity)})
          
          numSubjects <- length(unique(subject))
          numActivities <- length(unique(activity))
          
          # Create an empty data frame with descriptive column names
          column_names <- c("subject", "activity", features)
          averages <- data.frame(matrix(nrow=0, ncol=length(column_names)))
          colnames(averages) <- column_names
          
          # Populate the data frame with the average of each variable for each activity and each subject
          row = 1
          for (i in 1:numSubjects) {
               
               for (j in 1:numActivities) {
                    
                    observations <- data[[i]][[j]]
                    numObservations <- length(observations)
                    
                    averages[row, "subject"] <- observations$subject[1]
                    averages[row, "activity"] <- observations$activity[1]
                    averages[row, 3:numObservations] <- colMeans(observations[, 3:numObservations])
                    
                    row = row + 1
               }
          }
     
     # 6. Write the data set to a text file:
     
          write.table(averages, "averages_by_subject_and_activity.txt", row.names=F)
}