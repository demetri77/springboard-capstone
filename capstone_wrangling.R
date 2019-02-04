library(tidyverse)

## Read in file
#bankfull <- read.table("bank-additional-full.csv",header=TRUE,sep=";")
#bankfull <- read_delim("bank-additional-full.csv", delim = ";", col_types = "iccccccccciiiicdddddc")
#bankfull <- read_delim("bank-additional.csv", delim = ";", col_types = "iccccccccciiiicdddddc")
bankfull <- read_delim("bank-additional.csv", delim = ";", col_types = "iffcffffffiiiicdddddc")

#str(bankfull)
bankfull <- rename(bankfull, edu_lvl = "education")
bankfull <- rename(bankfull, cred_def = "default")
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

mutate(bankfull, duration_sec == "0")

etemp <- bankfull$edu_lvl
bankfull$edu_lvl <- gsub("\\.", "_", etemp)
bankfull$edu_lvl <- as.factor(bankfull$edu_lvl)

#is.factor(bankfull$subscribed)
bankfull$subscribed <- as.factor(bankfull$subscribed)
bankfull$prev_outcome <- as.factor(bankfull$prev_outcome)

glimpse(bankfull)

summary(bankfull)
#colnames(bankfull)

#tally(bankfull, subscribed == "0")
#tally(bankfull, subscribed == "1")
summary(bankfull$subscribed)

ggplot(bankfull, aes(x = subscribed)) + geom_bar()
ggplot(bankfull, aes(x = prev_outcome)) + geom_bar()

bankfull$prev_outcome[bankfull$prev_outcome == "nonexistent"] <- NA

xtabs(~prev_outcome+subscribed, bankfull)
plot(xtabs(~prev_outcome+subscribed, bankfull))

bankfull %>% mutate(duration_min = duration_sec/60)
summary(bankfull$duration_min)
boxplot(bankfull$duration_min)

#bankfull %>% select(edu_lvl, job) %>% group_by(edu_lvl, job) %>% arrange(desc(edu_lvl)) %>% slice(1:3)

bankfull %>% group_by(edu_lvl) %>% summarise(count = n()) %>% arrange(desc(count))
bankfull %>% group_by(job) %>% summarise(count = n()) %>% arrange(desc(count))

ggplot(bankfull, aes(x = euribor3m, y = cons.price.idx)) + geom_point()
ggplot(bankfull, aes(y = euribor3m, x = subscribed)) + geom_point

ggplot(data=bankfull, aes(x=edu_lvl, fill=subscribed)) + geom_bar()

## filter, select, arrange, mutate, summarise, group_by

## Variable selection
ggplot(bankfull, aes(x = job)) + geom_histogram(stat="count")
ggplot(bankfull, aes(x = job, fill=marital)) + geom_histogram(stat="count")
ggplot(bankfull, aes(x = job, fill=edu_lvl)) + geom_histogram(stat="count")

ggplot(bankfull, aes(x = edu_lvl, fill=subscribed)) + geom_histogram(stat="count")
ggplot(bankfull, aes(x = job, fill=subscribed)) + geom_histogram(stat="count")

ggplot(bankfull, aes(x=euribor3m, fill=subscribed)) + geom_bar(stat="count")

#weekdays <- c("Mon", "Tue", "Wed", "Thu", "Fri")
#Mon=0, Tue=1, ...
#group_by(group_by())

#dailyTally <- tally(bankfull, day_of_week == "mon")
#dailyTally[1] <- tally(bankfull, day_of_week == "tue")
#dailyTally[2] <- tally(bankfull, day_of_week == "wed")
#dailyTally[3] <- tally(bankfull, day_of_week == "thu")
#dailyTally[4] <- tally(bankfull, day_of_week == "fri")
#tibble(weekdays, dailyTally)

#groupby

ggplot(bankfull, aes(x=days_of_week)) + geom_bar()

# Outcome of previous campaign
ggplot(bankfull, aes(x = poutcome)) + geom_bar()

medCPI <- median(bankfull$cons_price_idx)
avgCPI <- mean(bankfull$cons_price_idx)

ggplot(bankfull, aes(x = marital, y = balance)) + geom_point()
ggplot(bankfull, aes(x = marital)) + geom_bar()


subY <- filter(bankfull, subscribed = "yes")
ggplot(subY, aes(x = duration, )) + geom_bar()


ggplot(bankfull, aes(x=duration, y=subscribed)) + geom_point()


ggplot(bankfull, aes()) + facet_grid()

ggplot(bankfull, aes(x = contact_typ, fill = subscribed)) + geom_bar()

edu_tmp <- as.factor(bankfull$edu_lvl)
plot(edu_tmp)
ggplot(edu_tmp, aes(x = edu_lvl)) + geom_bar()


model <- glm(subscribed ~ ., data = bankfull, family = binomial)
summary(model)

ggplot(bankfull, aes(x = age, fill = subscribed)) + 
  geom_histogram(binwidth = 10) + 
  labs(title = "Age distrubtion of current bank clients and those who subscribed") 

library(scales)
ggplot(bankfull, aes(x = age, fill = subscribed)) + 
  geom_histogram(binwidth = 10, aes(y=(..count../sum(..count..)))) + 
  scale_y_continuous(scale::percent) +
  labs(title = "Age distrubtion of current bank clients and those who subscribed") 

ggplot(bankfull, aes(job, fill=subscribed)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) + 
  scale_y_continuous(labels=scales::percent) +
  ylab("relative frequencies")

# ------------------------------
# ggpairs
# ------------------------------
library(GGally)

b_client <- bankfull[, c(1:7)]
b_client <- select(bankfull, age:loan)
ggpairs(b_client)

b_credit <- bankfull[, c("default", "housing", "loan")]
b_credit <- bankfull[, c("cred_default", "mortgage", "loan")]
ggpairs(b_credit)

b_soceco <- select(bankfull, emp_var_rate:euribor3m)
ggpairs(b_soceco)

# ------------------------------
# summarytools
# ------------------------------
library(summarytools)

# Data Frame Summaries
dfSummary(bankfull, plain.ascii=FALSE, style="grid")

dfSummary(b_client)

# Frequency
freq(bankfull$age)
freq(bankfull$loan)

# Cross-Tabulation
ctable(bankfull$edu_lvl, bankfull$subscribed)
ctable(bankfull$job, bankfull$subscribed)

# Descriptive Univariate Stats
descr(bankfull)

# Write/Export dataset
write_csv(bankfull, path="bankfull_clean.csv")
