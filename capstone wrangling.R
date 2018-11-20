library(tidyverse)

## Read in 
bank <- read_delim("bank/bank-full.csv", ";")
bank_add <- read_delim("bank-additional/bank-additional-full.csv", ";")

colnames(bank)
colnames(bank_add)

ggplot(bank, aes(x = y)) + geom_bar()
ggplot(bank_add, aes(x = y)) + geom_bar()

dsub2011 <- d2011raw %>% select(INSTNM, CITY, STABBR, NPT4_PUB, NPT4_PRIV, COSTT4_A, UNEMP_RATE, MD_EARN_WNE_P6, MD_EARN_WNE_P10, MN_EARN_WNE_P10)
filter(dsub2011, COSTT4_A != "NA")
summary(bank)
summary(bank_add)


d2017 <- read_csv("MERGED2016_17_PP.csv", na = c("", "NA", "NULL"))
#d2016a <- read_csv("MERGED2015_16_PP.csv")
#d2016b <- read_csv("MERGED2015_16_PP.csv", na = c("", "NA", "NULL"))

## Variable selection
# dsub2017 <- d2017 %>% select(INSTNM, CITY, STABBR, NPT4_PUB, NPT4_PRIV, COSTT4_A, UNEMP_RATE, MD_EARN_WNE_P10, MN_EARN_WNE_P10)
summary(dsub2017)

#rename(dsub2017$STABBR, dsub2017$STATE)

ggplot(bank, aes(x = job, color=marital)) + geom_histogram(stat="count")
ggplot(bank_add, aes(x=nr.employed)) + geom_bar()

median <- median(bank$balance)
#average <- mean(bank$balance)

#filter(bank, STABBR == "AK")
ggplot(bank, aes(x = marital, y = balance)) + geom_point()
ggplot(bank, aes(x = marital)) + geom_bar()

# write_csv(dsub2017, path="~/springboard-capstone/dsub2017.csv")
