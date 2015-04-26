#Required libraries make sure to install them.
library("foreign")
library(ggplot2)
library(caret)
#Change this code to your directory
#setwd("\\Documents\\Study\\CSCI 420\\Project\\ICPSR_26382\\ICPSR_26382\\DS0003\\")
#dir <- getwd()
data <- read.dta("26382-0004-Data.dta", convert.dates = TRUE, convert.factors = TRUE,
        missing.type = FALSE,
        convert.underscore = FALSE, warn.missing.labels = TRUE)

#Only social factors are taken
cleaned.data <- subset(data, select=c("V4479", "V4481B", "V4483", "V4485", "V4512", 
				"V4526I", "V4264", "V4279","V4243", "V4246", "V4022", "V4023",
				"V4023B","V4024","V4528"))

#########################################################
#DATA PREPROCESSING
#########################################################				
#1-4,15,16,18,19 Sexual Assault
#31-41 Household Crimes
#21-29 Personal Theft
#5-14,17,20 Violent Non-Sexual Crime

#Data preprocessing will happen here.
if()
	

	
##########################################################
#CLASSIFICATION
##########################################################
#K-Nearest Neighbor
#Doesn't work as of now.
#Works if we take V4528 as an integer, classifies it correctly
#97% of the time.
#Needs more data preprocessing.
set.seed(666)				
				
inTraining <- createDataPartition(cleaned.data$V4528, p = .75, list = FALSE)
training <- cleaned.data[inTraining,]
testing <- cleaned.data[-inTraining,]

fitControl <- trainControl(## 10-fold CV
                           method = "repeatedcv",
                           number = 10,
                           ## repeated ten times
                           repeats = 10)	
fit1 <- train(V4528 ~ ., data=training,
				method="knn",
				trControl = fitControl
				)
predict(fit1$finalModel, newdata = head(testing,1)[1:14])