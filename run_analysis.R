 setwd("~/Coursera/Getting and CLeaning Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
 library(plyr)
 library(data.table)
 subjectTrain = read.table('./train/subject_train.txt',header=FALSE)
 View(subject_train)
 train_x = read.table('./train/x_train.txt',header=FALSE)
 train_y = read.table('./train/y_train.txt',header=FALSE)
 subjectTest = read.table('./test/subject_test.txt',header=FALSE)
 test_x = read.table('./test/x_test.txt',header=FALSE)
 test_y = read.table('./test/y_test.txt',header=FALSE)
 dataset_x <- rbind(train_x, test_x)
 dataset_y <- rbind(train_y, test_y)
 dataset_subject <- rbind(subjectTrain, subjectTest)
 dataset_x_mean_std <- dataset_x[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
 names(dataset_x_mean_std) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2]
 dataset_y[, 1] <- read.table("activity_labels.txt")[dataset_y[, 1], 2]
 names(dataset_y) <- "Activity"
 names(dataset_subject) <- "Subject"
 new_dataset <- cbind(dataset_x_mean_std, dataset_y, dataset_subject)
 names(new_dataset) <- make.names(names(new_dataset))
 names(new_dataset) <- gsub('Acc',"Acceleration",names(new_dataset))
 names(new_dataset) <- gsub('GyroJerk',"Angular_Acceleration",names(new_dataset))
 names(new_dataset) <- gsub('Gyro',"Angular_Speed",names(new_dataset))
 names(new_dataset) <- gsub('Mag',"Magnitude",names(new_dataset))
 names(new_dataset) <- gsub('^t',"Time_Domain.",names(new_dataset))
 names(new_dataset) <- gsub('^f',"Frequency_Domain.",names(new_dataset))
 names(new_dataset) <- gsub('\\.mean',".Mean",names(new_dataset))
 names(new_dataset) <- gsub('\\.std',".Standard_Deviation",names(new_dataset))
 names(new_dataset) <- gsub('Freq\\.',"Frequency.",names(new_dataset))
 names(new_dataset) <- gsub('Freq$',"Frequency",names(new_dataset))
 Combined<-aggregate(. ~Subject + Activity, new_dataset, mean)
 Combined<-Combined[order(Combined$Subject,Combined$Activity),]
 write.table(Combined, file = "tidydata.txt",row.name=FALSE)