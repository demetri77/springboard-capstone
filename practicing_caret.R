library(caret)

bankfull <- read_delim("bank-additional.csv", delim = ";", col_types = "iccccccccciiiicdddddc")

bankfull <- rename(bankfull, edu_lvl = "education")
bankfull <- rename(bankfull, duration_sec = "duration")
bankfull <- rename(bankfull, contact_typ = "contact")
bankfull <- rename(bankfull, contact_cnt = "campaign")
bankfull <- rename(bankfull, days_passed = "pdays")
bankfull <- rename(bankfull, prev_contact_cnt = "previous")
bankfull <- rename(bankfull, prev_outcome = "poutcome")
bankfull <- rename(bankfull, emp_var_rate = "emp.var.rate")
bankfull <- rename(bankfull, cons_price_idx = "cons.price.idx")
bankfull <- rename(bankfull, cons_conf_idx = "cons.conf.idx")
bankfull <- rename(bankfull, num_employed = "nr.employed")
bankfull <- rename(bankfull, subscribed = y)

# CARET = Classification And REgression Training

# Pre-Processing / cleaning
preProcess(bankfull)

# Data Splitting
colname <- names(bankfull)
inTrain <- createDataPartition(bankfull$subscribed, times = 2, p = 0.75)

training <- bankfull[inTrain,]
testing <- bankfull[-inTrain,]
dim(training)

createResample()

createTimeSlices()

# Training/Testing Functions
modelFit <- train(subscribed ~ ., bankfull, method="glm")

glm(subscribed, bankfull, family = "binomial")

predictTest <- predict(obj, type = "response")

# Model Comparison
confusionMatrix()


