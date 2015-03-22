datasetURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datasetFile <- "UCI HAR Dataset.zip"
datasetDir <- "UCI HAR Dataset"
resultFile <- "results.txt"

if (!file.exists(datasetFile)) {
  download.file(datasetURL, destfile = datasetFile, method = "curl")
}

if (!file.exists(datasetDir)) {
  unzip(datasetFile)
}

train <- read.table(file.path(datasetDir, "train", "X_train.txt"))
train <- cbind(train, read.table(file.path(datasetDir, "train", "y_train.txt")))
train <- cbind(train, read.table(file.path(datasetDir, "train", "subject_train.txt")))

test <- read.table(file.path(datasetDir, "test", "X_test.txt"))
test <- cbind(test, read.table(file.path(datasetDir, "test", "y_test.txt")))
test <- cbind(test, read.table(file.path(datasetDir, "test", "subject_test.txt")))

dataset <- rbind(train, test)

features <- read.table(file.path("UCI HAR Dataset","features.txt"), colClasses=c("numeric","character"))
features_indexes <- grep("((mean|std)[(]|Mean)", features[[2]])
subject_index <- ncol(dataset)
y_index <- ncol(dataset)-1
dataset <- dataset[,c(features_indexes, y_index, subject_index)]

labels <- read.table(file.path(datasetDir, "activity_labels.txt"))
y_index <- ncol(dataset)-1
dataset <- merge(dataset, labels, by.x = y_index, by.y = 1)
dataset <- dataset[,-1]

feature_names <- gsub('[(][)]', '', features[features_indexes,2])
feature_names <- gsub('[)]', '', feature_names)
feature_names <- gsub('[-(,]', '.', feature_names)
names(dataset) <- c(feature_names, 'subject', 'activity')

summary <- summarise_each(group_by(dataset, subject, activity), funs(mean))
write.table(summary, file = resultFile, row.names = FALSE)