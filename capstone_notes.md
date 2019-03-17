## bank vs bank-add, 17
bank
06 - balance
10 - day

## bank-add, 21
10 - day_of_week
16 - emp.var.rate
17 - cons.price.idx, consumer price index
18 - cons.conf.idx, consumer confidence index
19 - euribor3m, Euro Inter-Bank Offer Rate at 3 months
20 - nr.employed, number employed at bank

EDA to gain insight; discrete vs continuous data
training vs test
60/20/20 - training, validation, testing
conclusion
produce 3 recommendations



# Apply Data Wrangling to Capstone

Submit a short report outlining data wrangling steps. This report will eventually become part of your milestone report for your Capstone.

1) Add your cleaned-up data set to the github repository for your project.
2) Summarize the most important steps you took in cleaning up your data in a short (1 page max) document. You may use any format of your choice (R Markdown, Google Docs, Word etc).

**Task List** 

* WARNING: Check specifications on column type
* RENAME: change the period '.' to "underscore"
* Within R-Markdown - pre, code, sentence summary
* color the graphs when possible for emphasis

changing edu_lvl factors to digits, such as 1 for primary education.

Import --> tidy (tidyr) --> transform (dplyr) --> visualize --> model --> communicate
                                | ------------------------------- |

__If you really want percentages.__
prop.table(table(titanic$Survived))

__facet_wrap__
ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  theme_bw() +
  facet_wrap(~ Pclass) +
  geom_bar() +
  labs(y = "Passenger Count",
       title = "Titanic Survival Rates by Pclass and Sex")

geom_quasirandom()
ggrepel()
ggbeeswarm()

** connecting, visualizing, and sharing data**

?xtabs

# Apply Statistics to Capstone

## Start with some statistical analysis on your capstone data set

1) Get going by asking the following questions and looking for the answers with some code and plots:
    1. Can you count something interesting?
    2. Can you find some trends (high, low, increase, decrease, anomalies)?
    3. Can you make a bar plot or a histogram?
    4. Can you compare two related quantities?
    5. Can you make a scatterplot?
    6. Can you make a time-series plot?

2) Having made these plots, what are some insights you get from them? Do you see any correlations? Is there a hypothesis you would like to investigate further? What other questions do they lead you to ask?
## Submit a short report on your statistical analysis

Now let's write down our findings in a short document. This document will become part of your milestone report, and eventually your final project report.
Summarize the most interesting or important findings from your analysis in a short (2-3 page) document. You may use any format of your choice (R Markdown, Google Docs, Word etc)


## Machine Learning

Work on 2 of 4 data models

* logistic regression
* decision trees (?? difference vs random forests; bootstrapped dataset, out-of-bag error vs test set?) random forests handles overfitting better

**Omission:**

* X -> neural network model
* X -> support vector machine model
* X -> tuning is overkill atm; what are hyper parameters?

CARET (to go from log regression to random forest, from glm to rf)
split data
random forest
confusion matrix


**Skip decision trees**

**Create a black box model for exploratory reasons**


# NB: Random Forests
[Random Forests](https://towardsdatascience.com/the-random-forest-algorithm-d457d499ffcd)
** Use Cases: **
The random forest algorithm is used in a lot of different fields, like Banking, Stock Market, Medicine and E-Commerce. In Banking it is used for example to detect customers who will use the bank’s services more frequently than others and repay their debt in time. In this domain it is also used to detect fraud customers who want to scam the bank. 

** how come sometimes the stored variables go into "." like dummy.vars? **


## caret package tutorials ##
http://www.edii.uclm.es/~useR-2013/Tutorials/kuhn/user_caret_2up.pdf
XX -> http://cran.r-project.org/web/packages/caret/vignettes/caret.pdf
https://cran.r-project.org/web/packages/caret/vignettes/caret.html
http://www.jstatsoft.org/v28/i05/paper

R pkg required:
e1071, caret, doSNOW, ipred, and xgboost


**Missing inputs: strategies**

* Delete row/column
  * index_NA <- which(is.na(loan_data$emp_length))
  * loan_data_no_NA <- loan_data[-c(index_NA),]
* Replace
  * index_NA <- which(is.na(loan_data$emp_length))
  * loan_data_replace <- loan_data
  * loan_data_replace$emp_length[index_NA] <- median(loan_data$emp_length, na.rm = TRUE)
* Keep NA
* extra column to mark imputed/non-imputed

completeCase

*log_model <- glm(subscribed~., data=bankfull_clean, family="binomial")*

*Dealing with the disparity of dependent variable; 95% no vs 5% yes*
sub-sample

**REMOVED** Let's take care of _missing values_ as necessary
```{r}
bankfull <- read_delim(file = "bank-additional.csv", delim = ";", col_types = "iccccccccciiiicdddddc")

There are only 2 possible values for the dependent variable, "subscribed". As
such I'll convert the variable to type factor.
```{r}
bankfull$subscribed <- as.factor(bankfull$subscribed)
```

bankfull$marital[bankfull$marital == "unknown"] <- NA
bankfull$marital <- as.factor(bankfull$marital)

bankfull$cred_default[bankfull$cred_default == "unknown"] <- NA
bankfull$cred_default <- as.factor(bankfull$cred_default)

bankfull$housing[bankfull$housing == "unknown"] <- NA
bankfull$housing <- as.factor(bankfull$housing)

bankfull$prev_outcome[bankfull$prev_outcome == "nonexistent"] <- NA
bankfull$prev_outcome <- as.factor(bankfull$prev_outcome)
```

When tabling the results we immediately see most customers will reject the 
subscription offer.
```{r}
table(bankfull$subscribed)
```

```
library(randomForest)
n <- nrow(bankfull_clean)

rf.train.1 <- bankfull_clean[1:n, c("age", "edu_lvl")]
rf.label <- as.factor(bankfull_clean$subscribed)

set.seed(1234)
rf.1 <- randomForest(x=rf.train.1, y=rf.label, importance=TRUE, ntree=500)
rf.1

varImpPlot(rf.1)
```

```{r REMOVED}
# applying preProcess to scale/standardize/normalize
#preProcess_missingdata <- reProcess(trainData, method='knnImpute')
#preprocessed <- preProcess(trainData, method=c("scale"))
```

anyNA
bankfull_clean %>% map_lgl(anyNA)
`purrr::map_lgl()`

str_detect(string, pattern)

Questions
not sure why write_csv(bankfull, path=bankfull_clean) failed to capture an update df

geom_boxplot

# ggpairs
# change the level order for subscribed yes/no 
0.97 correlation -> euribor3m vs employment variation rate

Feature Groups

* bank client data
* last contact data
* other attributes
* social & economic context attributes

preProcess used to: scale, standardize, normalize
methods

* scale - remove anomalies; divide values by st-dev
* center - used to standardize; subtract mean from values
* range - used to normalize; normalize values

*Steps*

1. createDataPartition
2. preprocess
3. train
4. predict - used to apply model
5. confusionMatrix


not extremely sensitive to scaling: logistic regression and random forest

reminder: preProcess on both training & testing


# Presentation / Slide-Deck
 1. Title
 2. Content
 3. The Business Problem
 4. Data Wrangling
 5. EDA: Visualizations
 6. EDA: Key Findings
 7. EDA: Details
 8. Hypothesis Tests
 9. Predictive Modeling
10. Training / Testing / Feature Engineering
11. Comparisons of Models Tried
12. Feature Importance
13. Conclusions / Future Work

```{r}
#dummyModel <- dummyVars(subscribed~.,data=bankfull_clean)
#trainData_mat <- predict(dummyModel, newdata = trainData)
#trainData <- data.frame(trainData_mat)
```

```{r experimental_rf}
library(randomForest)
n <- nrow(bankfull_clean)

rf.train.1 <- bankfull_clean[1:n, c("age", "edu_lvl")]
rf.label <- as.factor(bankfull_clean$subscribed)

set.seed(1234)
rf.1 <- randomForest(x=rf.train.1, y=rf.label, importance=TRUE, ntree=500)
rf.1

varImpPlot(rf.1)
```

? Naming CodeChunks
? most subscriptions vs ratio of subscriptions
? 273-275; unable to identify var names: bankfull %>% filter(subscribed == "yes") %>% select(month)
? correlation data
? box plot interpretations

2019-02-19
? is there a way to display freq/count results in bars for geom_bar

2019-02-26
? difficulty setting margins in .Rmd, chunk settings w/in Rmd

2019-03-05
? since duration_sec isn't a real world predictor, i'll have to remove it for the test case
? removing loan and contacted
? 1st variables to watch: monthMAR, duration_sec
? 2nd variables to watch: contact_typeTELEPHONE, prev_outcomeNON
? 3rd variables to watch: monthJUN, monthAUG, contact_cnt, prev_outcomeSUC
? 4th variables to watch: mortgageNO, cons_conf_idx

why would the contact_typTELE be of more significance if twice as many cellular 

ifffffffffiiiifdddddf
ifffffffffiiiifdddddf
