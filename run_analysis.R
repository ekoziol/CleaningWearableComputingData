## This script will take in data from the data folder and combine it

#import the training data, test data and labels
x_train <- read.table("data/train/X_train.txt")
y_train <- read.table("data/train/y_train.txt")
x_test <- read.table("data/test/X_test.txt")
y_test <- read.table("data/test/y_test.txt")

activity_labels <- read.table("data/activity_labels.txt")
features <- read.table("data/features.txt")
# strip punctuation from feature names

features <- sapply(X=features, FUN=gsub,
                   pattern="[[:punct:]]", "", replacement="")

#sapply turns features in a list so turn back into a data frame or else code breaks
features <- data.frame(features)

#combine the train and test sets into a combined data frame
x_combined <- rbind(x_train, x_test)
y_combined <- rbind(y_train, y_test)

#clean feature names

#apply names to combined x set
names(x_combined) <- as.vector(features[["V2"]])

# Get all feature names that have either mean or std in them.
# Use this set to extract only the columns in this set. Order
# these columns so that like descriptors are next to each other.

theMeans <- sapply(X=features["V2"], FUN=grep,
                   pattern="mean", value=FALSE)
theStds <- sapply(X=features["V2"], FUN=grep,
                  pattern="std", value=FALSE)
desiredDescriptors <- c(theMeans, theStds)
featuresSelect <- features[desiredDescriptors, "V2"]
#select the columns of interest from the x data set
x_combinedSelected <- x_combined[,featuresSelect]

#Apply labels to activities in y_combined
y_combinedNamed <- merge(y_combined, activity_labels,
                         sort = FALSE)
y_combinedNamed <- data.frame(y_combinedNamed[,"V2"])
names(y_combinedNamed) <- "activity"

#Begin creation of the tidy data set
#import subjects and combine into one list
subject_train <- read.table("data/train/subject_train.txt")
subject_test <- read.table("data/test/subject_test.txt")
subject_combine <- rbind(subject_train, subject_test)

#combine subjects, y labels and x data into one data frame
superData <- cbind(subject_combine, y_combinedNamed, x_combined)
#sapply(split(superData[3:563], c(), mean)