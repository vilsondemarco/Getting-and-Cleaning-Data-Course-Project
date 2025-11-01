# Calling and installing packages used in this script.

packages <- installed.packages()
if("dplyr" %in% rownames(packages) == FALSE) 
  install.packages("dplyr")
if("tidyverse" %in% rownames(packages) == FALSE) 
  install.packages("tidyverse")
library(dplyr)
library(tidyverse)

# Downloading and Extracting the data:

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="data.zip")
unzip("data.zip")

# First we read the messy data into the R environment.
# The variables were named as the original files so it gets easier to follow
# what happens to them next.

features <- read.table(file.path("UCI HAR Dataset/features.txt"))
activity_labels <- read.table(file.path("UCI HAR Dataset/activity_labels.txt"))
x_test <- read.table(file.path("UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(file.path("UCI HAR Dataset/test/y_test.txt"))
subject_test <- read.table(file.path("UCI HAR Dataset/test/subject_test.txt"))
x_train <- read.table(file.path("UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(file.path("UCI HAR Dataset/train/y_train.txt"))
subject_train <- read.table(file.path("UCI HAR Dataset/train/subject_train.txt"))

# Now we proceed to properly label the tables. 
# The x_test and x_train names are inside the features.txt file. The readme was 
# very clunky to navigate, but after exploring the files, we got pretty 
# confident that this was correct, since one has 561 observations and 
# the other has 561 variables.

colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2]

# The y_test and y_train were easier to understand from the readme files, they 
# just list the activity the subjects are doing, as labeled in the 
# activity_labels.txt file. Renaming them has no impact in the resulting file, 
# but it makes the script clearer and future operations easier to follow.

colnames(activity_labels) <- c("activity","activity_labels")
colnames(y_train) <- "activity"
colnames(y_test) <- "activity"

# The subject files had a list with the 30 subjects from the experiment, so the
# decision as to how to label them was pretty straightforward.

colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"

# Now we will start to combine the data from the different files. Each group 
# will be labeled as the original files, for clarity.

x_group <- rbind(x_train,x_test)
y_group <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)

# After this, we will grab the measurements the assignment asks us to: the data 
# from mean and standard deviation. Since the  values we need are all preceded
# by a - and followed by a (), which gives us confidence that we will not get
# any undesired value.

mean_std <- grep("-(mean|std)\\(\\)",features[,2])
x_group <- x_group[,mean_std]

# Our first round of clean-ups will focus on properly using the desired 
# variables and dealing with the operators that are in their names, following 
# the tidydata good practices guideline. We will first remove the () from their 
# names and then change all - into _.

names(x_group) <- gsub("\\()", "",features[mean_std,2])
names(x_group) <- gsub("-", "_",names(x_group))

# Now all we will start binding our data files together.
# We start by doing it in a bulk.

bulk_data <- cbind(subject,y_group,x_group)

# Our first task is to change the activity codes into their proper labels, 
# as described in activity_labels. We do that by matching or bulk_data with
# the activity_labels, by the shared activity variable we renamed previously. 
# Since the code isn't necessary anymore, we will remove it from our bulk_data 
# and properly name this dataset as tidy_data.

bulk_data <- merge(bulk_data,activity_labels,by="activity",all.x=TRUE)
tidy_data <- select(bulk_data,subject,activity_labels,everything(),-activity)
rm(bulk_data)

# Our last clean-up with the original dataset is to lowercase the name
# of the variables, following the tidydata guidelines. Some would argue that
# they are not as easily readable by  the human eye, but it will be easier to
# type and manipulate the dataset in the future.

colnames(tidy_data) <- tolower(colnames(tidy_data))

# We then proceed to finalize the assignment, creating a independent tidy 
# dataset with the average of each variable, for each activity and subject. 

tidy_data_avg <- group_by(tidy_data,subject,activity_labels)
tidy_data_avg <- summarise_all(tidy_data_avg,mean)

# Now all we need to do is write down the file.

write.table(tidy_data_avg,"tidy_dataset.txt",row.name=FALSE)