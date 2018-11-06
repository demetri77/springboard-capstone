
## Read in 
library(tidyr)
d2016 <- read_csv("MERGED2016_17_PP.csv")

## Variable selection
library(dplyr)
dsub2016 <- d2016 %>% select(INSTNM, CITY, STABBR, NPT4_PUB, NPT4_PRIV, COSTT4_A, UNEMP_RATE, MD_EARN_WNE_P10, MN_EARN_WNE_P10)
