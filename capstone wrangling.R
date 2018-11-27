library(tidyverse)

## Read in file
bankfull <- read_delim(file = "bank-additional-full.csv", delim = ";")

#str(bankfull)
glimpse(bankfull)
#colnames(bankfull)[colnames(bankfull) == "y"] <- "subscribed"
#colnames(bankfull)[colnames(bankfull) == "nr.employed"] <- "num.employed"
#select(bankfull, y = subscribed)
bankfull <- rename(bankfull, CPI = "cons.price.idx")
bankfull <- rename(bankfull, CCI = "cons.conf.idx")
bankfull <- rename(bankfull, subscribed = y)

summary(bankfull)
colnames(bankfull)

tally(bankfull, subscribed == "no")
tally(bankfull, subscribed == "yes")

ggplot(bankfull, aes(x = subscribed)) + geom_bar()

bankfull %>% select(education, job) %>% group_by(education, job) %>% arrange(desc(education)) %>% slice(1:3)
bankfull %>% group_by(education) %>% summarise(count = n()) %>% arrange(desc(count))
bankfull %>% group_by(job) %>% summarise(count = n()) %>% arrange(desc(count))

ggplot(bankfull, aes(x = euribor3m, y = CPI)) + geom_point()

## filter, select, arrange, mutate, summarise, group_by

## Variable selection

ggplot(bankfull, aes(x = job, fill=marital)) + geom_histogram(stat="count")

# Outcome of previous campaign
ggplot(bankfull, aes(x = poutcome)) + geom_bar()

medCPI <- median(bankfull$CPI)
avgCPI <- mean(bankfull$CPI)



ggplot(bankfull, aes(x = marital, y = balance)) + geom_point()
ggplot(bankfull, aes(x = marital)) + geom_bar()

bankfull %>% print(n = 10)

# summarytools

# Write/Export dataset
write_csv(bank, path="~/springboard-capstone/bank_new.csv")
