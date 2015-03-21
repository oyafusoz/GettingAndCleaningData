############################
## Zack Oyafuso
############################

library(plyr)
setwd("C:\\Users\\Mervin\\Google Drive\\Get_Clean_Data")

#Bring in the variable names spreadsheet and rename it to something useful
features <- read.table("features.txt", stringsAsFactors = F)
names(features) = c("Variable No", "var_name")

#Read in the test and train files and rename the columns
setwd("C:\\Users\\Mervin\\Google Drive\\Get_Clean_Data\\test")
xtest <- read.table("X_test.txt", col.names = features$var_name)

setwd("C:\\Users\\Mervin\\Google Drive\\Get_Clean_Data\\train")
xtrain <- read.table("X_train.txt", col.names = features$var_name)

#Merge (rbind) the two datasets
fulldf = rbind(xtest, xtrain)

#Only extract the columns with either 'mean.' or 'std' in the name
fulldf = fulldf[,grep('mean[.]|std', names(xtrain))] #[.]removes mean frequency columns(idf whether we need those)

#Steps 3 and 4 confuse me..

#Last step

#Just extract the columns with the mean variables
fulldf_mean = fulldf[,grep('mean', names(fulldf))]

#Create a df with the means of all the activities over all subjects
tidydf = data.frame(activity = names(fulldf_mean), mean = as.vector(apply(fulldf_mean, MARGIN = 2, FUN = mean)))

#Remove the '.mean...' in each of the names
tidydf$activity = gsub('.mean..', '', tidydf$activity)
