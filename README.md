# JHU03_CleaningData
JHU03 Getting and Cleaning Data

This repo contains the files produced in the Getting and Cleaning Data course. The files include:

README.md - This file which contains the general introduction to the repo.
entireDataset.txt - File created after combining the test and training data for the X, Y and subject files. It has a dimension of 10299 observations of 564 variables.

tidyDataset.txt - The dataset manufactured during the exercise. It contains the variables subject, activity, and the 66 measurements of means and standard deviations extracted from the entire dataset. It has dimensions of 180 observations of 68 variables.

run_Analysis.R - the code that takes as input data from the UCI HAR Dataset: X_train.txt, Y_train.txt, subject_train.txt, X_test.txt, Y_test.txt, subject_test.txt) and labels from features.txt and activity_labels.txt. Descriptions of the steps utilized in the R code are provided as comments

UCI HAR Dataset - The unzipped directory of the data files from the University of California at Irvine. The data files used in this analysis are located in "./data/", "./data/test/" and "./data/train/".