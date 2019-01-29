library(caret)
library(kernlab)
data(spam)

inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)

set.seed(32343)
modelFit <- train(type ~ ., data=training, method="glm")
modelFit
modelFit$finalModel

predictions <- predict(modelFit, newdata=testing)
predictions

confusionMatrix(predictions, testing$type)

# -------------------
# capstone style
# -------------------
library(tidyverse)
bankfull_clean <- read_delim(file = "bank-additional.csv", delim = ";", col_types = "ifffffffffiiiicdddddc")
#bankfull_clean <- read_csv("bankfull_clean.csv", col_types = "iccccccccciiiicdddddc")
#bankfull_clean <- read_delim(file = "bank-additional.csv", delim = ";", col_types = "iccccccccciiiicdddddc")

## Logistic Regression
inTrain <- createDataPartition(y=bankfull_clean, p=0.75, list=FALSE)
training <- bankfull_clean[ inTrain,]
testing  <- bankfull_clean[-inTrain,]

set.seed(13456)
modelFit <- train(y ~ ., data=training, model="glm")

predictions <- predict(modelFit, newdata=testData)

confusionMatrix(predictions)


# -------------------
# caret vignettes
# https://cran.r-project.org/web/packages/caret/vignettes/caret.html
# -------------------

library(mlbench)
data(Sonar)

set.seed(107)
inTrain <- createDataPartition(
  y = Sonar$Class,
  ## the outcome data are needed
  p = .75,
  ## The percentage of data in the
  ## training set
  list = FALSE
)
## The format of the results

## The output is a set of integers for the rows of Sonar
## that belong in the training set.
str(inTrain)
#>  int [1:157, 1] 1 2 3 6 7 9 10 11 12 13 ...
#>  - attr(*, "dimnames")=List of 2
#>   ..$ : NULL
#>   ..$ : chr "Resample1"

# -------------------
# Building a Pipeline - Benjamin Manning
# -------------------

library(caret)
iris <- datasets::iris
set.seed(998)

# define 75/25 train/test split of the dataset
inTraining <- createDataPartition(iris$Species, p=0.75, list=FALSE)
training <- iris[ inTraining,]
testing  <- iris[-inTraining,]

# 10-fold cross validation
fitControl <- trainControl(method="repeatedcv", number=10, repeats=1)

# method = "rf" i.e. Random Forest
system.time(
  rfFit1 <- train(Species~., data=training, method="rf", trControl=fitControl)
)
#rfFit1 <- train(Species~., data=training, method="extraTrees", trControl=fitControl)

# training results
rfFit1

# -------------------
# Max Kuhn's webinar
# -------------------

library(C50)
data(churn)
str(churnTrain)

predictors <- names(churnTrain)[names(churnTrain) != "churn"]
#names(churnTrain)
colnames(churnTrain)

set.seed(1)
inTrainingSet <- createDataPartition(allData$churn,
                                     p = 0.75, list = FALSE)
churnTrain <- allData[ inTrainingSet,]
churnTest  <- allData[-inTrainingSet,]

# Other DataSplitting fxn:
# createFolds, createMultiFolds, createResamples

# preProcess calcuates values that can be used to apply to any data set
preProcess_data <- preProcess(churnTrain)

# Current methods: centering, scaling, ...

numerics <- c("account_length", "total_day_calls")

# ---------------------
# ML Mastery
# ---------------------
library(caret)
data(iris)
original <- iris[,1:4]
#summary(original)

# center: subtract mean from values
preprocess_center <- preProcess(original, method=c("center"))

# scale: divide values by stdev
preprocess_scale <- preProcess(original, method=c("scale"))
#print(preprocessParams)

# range: normalized
preprocess_range <- preProcess(original, method=c("range"))

transformedC <- predict(preprocess_center, original)
transformedS <- predict(preprocess_scale, original)
transformedR <- predict(preprocess_range, original)
#summary(transformed)



library(GGally)
ggpairs(original)
ggpairs(transformedC)
ggpairs(transformedS)
