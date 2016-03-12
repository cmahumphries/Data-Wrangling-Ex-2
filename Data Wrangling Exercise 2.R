#load csv as data frame

my_df <- read.table("titanic_original.csv", header = TRUE, sep = ",")

#load dplyr
library(dplyr)

#1: Port of embarkation: find missing value and chanage to S

my_df$embarked[my_df$embarked == ""] <- "S"

#2: Age: find mean age, populate missing values

my_df$age[is.na(my_df$age)] <- mean(my_df$age, na.rm = TRUE)

#2B: instead of populating missing ages with mean of group,
#could create client profiles based on other info available 
#and use means for those groups. E.G.: compare class, gender,
#etc. and find means for those groups. More work, but should
# be more accurate.

#3: Lifeboat: fill kssing values with NA

my_df$boat[my_df$boat == ""] <- NA

#4: Cabin: create new has_cabin_number column 

#Does it make sense to fill missing cabin numbers with a value? NO
#What does a missing value here mean? Most 1st class passengers have
#a cabin, few 2nd or 3rd class passengers do. Seems to indicate either
#lost information, or poor record keeping

my_df <- my_df %>% mutate(has_cabin_number = cabin)
my_df$has_cabin_number <- ifelse(my_df$has_cabin_number == "", my_df$has_cabin_number <- 0, my_df$has_cabin_number <- 1)

#6: Submit the project on Github

write.csv(my_df, file = "titanic_clean.csv")
