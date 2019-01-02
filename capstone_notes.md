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
# If you really want percentages.
prop.table(table(titanic$Survived))

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
http://cran.r-project.org/web/packages/caret/vignettes/caret.pdf
https://cran.r-project.org/web/packages/caret/vignettes/caret.html

R pkg required:
e1071, caret, doSNOW, ipred, and xgboost