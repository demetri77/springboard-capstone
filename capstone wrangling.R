library(tidyverse)

## Read in file
#bankfull <- read.table("bank-additional-full.csv",header=TRUE,sep=";")
#bankfull <- read_delim(file = "bank-additional-full.csv", delim = ";", col_types = cols(.default = "c"))
bankfull <- read_delim("bank-additional-full.csv", delim = ";", col_types = "iccccccccciiiicdddddc")

#str(bankfull)
glimpse(bankfull)
bankfull <- rename(bankfull, contact_cnt = "campaign")
bankfull <- rename(bankfull, days_passed = "pdays")
bankfull <- rename(bankfull, prev_contact_cnt = "previous")
bankfull <- rename(bankfull, prev_outcome = "poutcome")
bankfull <- rename(bankfull, emp_var_rate = "emp.var.rate")
bankfull <- rename(bankfull, cons_price_idx = "cons.price.idx")
bankfull <- rename(bankfull, cons_conf_idx = "cons.conf.idx")
bankfull <- rename(bankfull, num_employed = "nr.employed")
bankfull <- rename(bankfull, subscribed = y)

summary(bankfull)
colnames(bankfull)

tally(bankfull, subscribed == "no")
tally(bankfull, subscribed == "yes")
ggplot(bankfull, aes(x = subscribed)) + geom_bar()
ggplot(bankfull, aes(x = pre_outcome)) + geom_bar()


bankfull %>% 
  select(education, job) %>% 
  group_by(education, job) %>% 
  arrange(desc(education)) %>% 
  slice(1:3)

bankfull %>% group_by(education) %>% summarise(count = n()) %>% arrange(desc(count))
bankfull %>% group_by(job) %>% summarise(count = n()) %>% arrange(desc(count))

ggplot(bankfull, aes(x = euribor3m, y = cons.price.idx)) + geom_point()
ggplot(bankfull, aes(y = euribor3m, x = subscribed)) + geom_point()

## filter, select, arrange, mutate, summarise, group_by

## Variable selection

#ggplot(bankfull, aes(x = job, fill=marital)) + geom_histogram(stat="count")

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
