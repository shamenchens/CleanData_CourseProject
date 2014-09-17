library(data.table)

# Step 0. Prepare training and testing dataset
trainData <- read.table('train/X_train.txt')
trainLabel <- read.table('train/y_train.txt', col.names = c('Activity'))
trainSubject <- read.table('train/subject_train.txt', col.names = c('Subject'))

testData <- read.table('test/X_test.txt')
testLabel <- read.table('test/y_test.txt', col.names = c('Activity'))
testSubject <- read.table('test/subject_test.txt', col.names = c('Subject'))

features <- read.table('features.txt')
activity <- read.table('activity_labels.txt', col.names = c('ActivityClass', 'ActivityName'))

# Step 1. Merges the training and the test sets to create one data set
data.train <- data.frame(trainData, trainLabel, trainSubject)
data.test <- data.frame(testData, testLabel, testSubject)
data.all <- rbind(data.train, data.test)

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement
cols <- paste("V", features[grep('mean|std', features[,"V2"]),]$V1, sep = "")
cols <- c(cols, 'Activity', 'Subject')
data.mean_std <- subset(data.all, select = cols)

# Step 3. Uses descriptive activity names to name the activities in the data set
colname <- as.character(features[grep('mean|std', features[,"V2"]),]$V2)
colname <- c(colname, 'ActivityClass', 'Subject')
colnames(data.mean_std) <- colname

# Step 4. Appropriately labels the data set with descriptive variable names
data.merge <- merge(data.mean_std, activity, by.x = 'ActivityClass', by.y = 'ActivityClass')

# Step 5. Creates a second, independent tidy data set with the average of
#         each variable for each activity and each subject
tidydata <- data.table(data.merge)
tidydata <- tidydata[, lapply(.SD, mean(na.rm = TRUE)), by = c("ActivityName", "Subject")]

write.table(tidydata, file = "tidydata.txt")