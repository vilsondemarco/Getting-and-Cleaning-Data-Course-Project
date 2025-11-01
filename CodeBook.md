# Codebook

## 1. Overview:
This code book is meant to provide additional information on the dataset used and the variables and the processess applied in this project, following the guidiles provided in the [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/) course, in the Coursera learning platform.

## 2. Dataset:

As provided by the [original researchers](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones):

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## 3. Variables:

To keep it as easy to follow as possible, we tried to maintain the name of the variables consistent with the name of the files we are using, the processes we are applying, and the current state of the dataset.
- **features**: read the features.txt file, and carries the name of all the variables in the original dataset.
- **activity_labels**: read the activity_labels.txt file, and carries the name of the six performed activities.
- **subject test and train**: read the respective .txt file with a list of the subjects in the testing and training subsets.
- **x and y train and test**: read the respective .txt files with the raw data collected during the experiment.
- **x and y group**: a support variable used to roughly bind the subsets.
- **mean_std**: a support variable used to capture only the values this project wants to process, which are the means and the standard deviations from every read.
- **bulk_data**: a support variable that stores early versions of our final output, during process.
- **tidy_data**: a general table where every concept of the tidy dataset guidelines were applied.
- **tidy_data_avg**: the output file of the project, written as tidy_dataset.txt.


## 4: Processes:

1. Merge and label the training and the test subsets.
2. Draw the measurements that interest us: the mean and the standard deviation.
3. Apply the correspondent activity names to the variables.
4: Clean up round, labeling the variables accordingly to the tidy data guidelines.
5. Build and output a second dataset, with the average of each variable for each activity and each subject.

## 5. Output:

- **Name**: tidy_dataset.txt
- **Rows**: 180, listing the 30 subjects doing the 6 activities
- **Columns**: 68, listing the reading variables
- **Format**: a text file with tabular separators (like the original files), saved as `tidy_dataset.txt`.