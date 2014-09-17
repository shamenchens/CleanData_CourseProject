Here are the steps in the code that transfrom raw data into tidy data.

**Step 0**: Read all data sets and store in variables, including:
- **trainData**: Training set
- **trainLabel**: Training label
- **trainSubject**: Training subject
- **testData**: Testing set
- **testLabel**: Testing label
- **testSubject**: Testing subject
- **features**: List of all features
- **activity**: Class labels with activity name

**Step 1**: Merges the training and the test sets to create one data set
- **data.train**: Combine all train data - *trainData*, *trainLabel*, *trainSubject*
- **data.test**: Combine all test data - *testData*, *testLabel*, *testSubject*
- **data.all**: Combine *data.train*, *data.test*

**Step 2**: Extracts only the measurements on the mean and standard deviation for each measurement
- **cols**: Read the columns that has mean or standard deviation in measurement
- **data.mean_std**: Subset *data.all*, and only keep columns defined in *cols*

**Step 3**: Uses descriptive activity names to name the activities in the data set
- **colname**: Uses activity name as column name for *data.mean_std*

**Step 4**: Appropriately labels the data set with descriptive variable names
- **data.merge**: Merge *data.mean_std* and *activity* by 'ActivityName'

**Step 5**: Creates a second, independent tidy data set
- **tidydata**: Use data.table package to process *data.merge*, calculate the
average of each variable for each activity and each subject, and write text file
