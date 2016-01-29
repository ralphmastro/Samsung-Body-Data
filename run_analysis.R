## Assignment for week 4 of Getting & Cleaning Data

library(dplyr)
library(stringr)
library(memisc)
# pull in the training and test data, as well as their labels.

test_data <- read.table('/UCI HAR Dataset/test/X_test.txt')
test_labels <- read.table('/UCI HAR Dataset/test/y_test.txt')
test_subject <- read.table('/UCI HAR Dataset/test/subject_test.txt')

train_data <- read.table('/UCI HAR Dataset/train/X_train.txt')
train_labels <- read.table('/UCI HAR Dataset/train/y_train.txt')
train_subject <- read.table('/UCI HAR Dataset/train/subject_train.txt')


act_lab <- read.table('/UCI HAR Dataset/activity_labels.txt')
features <- read.table('/UCI HAR Dataset/features.txt')

names(test_data)<-features$V2
names(train_data)<-features$V2
names(test_subject) <- 'subject'
names(train_subject) <- 'subject'
# extract mean and sd 

key <- grep("(.std.|.mean.)",features$V2)

test_data <- test_data[,key]
train_data <- train_data[,key]

# merge the action labels in

names(act_lab) <- c('V1','action')

test_labels <- merge(x = test_labels, y = act_lab,
                     by.x = 'V1', by.y ='V1',all.x = TRUE,
                     sort = FALSE)
train_labels <- merge(x = train_labels, y = act_lab,
                     by.x = 'V1', by.y ='V1',all.x = TRUE,
                     sort = FALSE)
names(test_labels) = c('action_label','action')
names(train_labels) = c('action_label','action')

test_data <- cbind(test_subject,test_labels,test_data)
train_data <- cbind(train_subject,train_labels, train_data)

# append the data sets together

finaldata1 <- tbl_df(rbind(test_data, train_data))

# get subject X activity average

fd2 <- group_by(finaldata1, subject,action)

finaldata2 <- fd2 %>% summarise_each(funs(mean))


# Generating codebook
finalDataCodeBook = codebook(as.data.frame(finaldata2))

# Output codebook
capture.output(finalDataCodeBook, file = 'Codebook.txt')
capture.output(finalDataCodeBook, file = 'Codebook.md')

write.table(finaldata2,file='tidydata.txt', row.names = FALSE)



