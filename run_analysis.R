run_analysis <- function(directory) {
     
     #directory <- 'C:/Users/moblander/Desktop/Coursera/2 - Getting and Cleaning Data/Course Project/Dataset'
     activity.labels.file <- paste(directory, 'activity_labels.txt', sep="/");
     feature.labels.file <- paste(directory, 'features.txt', sep="/");
     test.file <- paste(directory, 'test/X_test.txt', sep="/");
     test.subject.file <- paste(directory, 'test/subject_test.txt', sep="/");
     test.activity.file <- paste(directory, 'test/y_test.txt', sep="/");
     train.file <- paste(directory, 'train/X_train.txt', sep="/");
     train.subject.file <- paste(directory, 'train/subject_train.txt', sep="/");
     train.activity.file <- paste(directory, 'train/y_train.txt', sep="/");
     
     test <- read.table(test.file);
     train <- read.table(train.file);
     
     feature.labels <- read.table(feature.labels.file, stringsAsFactors=F)[,2];
     colnames(test) <- feature.labels;
     colnames(train) <- feature.labels;
     
     feature.labels.mean.std <- c(grep("mean\\(\\)",feature.labels), grep("std\\(\\)",feature.labels));
     feature.labels.mean.std <- feature.labels.mean.std[order(feature.labels.mean.std)];
     
     test <- subset(test, select=feature.labels.mean.std);
     train <- subset(train, select=feature.labels.mean.std);
     
     test.subject <- read.table(test.subject.file, stringsAsFactors=F)[,1];
     train.subject <- read.table(train.subject.file, stringsAsFactors=F)[,1];
     
     activity.labels <- read.table(activity.labels.file, stringsAsFactors=F);
     
     test.activity <- read.table(test.activity.file, stringsAsFactors=F)[,1];
     train.activity <- read.table(train.activity.file, stringsAsFactors=F)[,1];
     
     # Replace the activity ids with the labels:
     test.activity <- activity.labels[match(test.activity, activity.labels[[1]]),2];
     train.activity <- activity.labels[match(train.activity, activity.labels[[1]]),2];
     
     test <- cbind(test.subject, test.activity, test);
     colnames(test)[1] <- "subject";
     colnames(test)[2] <- "activity";
     
     train <- cbind(train.subject, train.activity, train);
     colnames(train)[1] <- "subject";
     colnames(train)[2] <- "activity";
     
     data <- rbind(test, train);
     
     data.by.subject <- split(data, data$subject);
     data.by.subject <- lapply(data.by.subject, function(x){subset(x, select=c(2:68))});
     data.by.subject.by.activity <- lapply(data.by.subject, function(x){split(x, x$activity)});
     data.by.subject.by.activity <- lapply(data.by.subject.by.activity, function(x){lapply(x, function(y){subset(y, select=c(2:67))})});
     data.by.subject.by.activity <- lapply(data.by.subject.by.activity, function(x){lapply(x, colMeans)});
     
     write.table(data.by.subject.by.activity, "averages_by_activity_for_each_subject.txt", row.names=F);
}