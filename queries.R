#queries.R
install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
names(DataDB)

SP <- DataDB %>% filter(Language == "Spanish")
SP.df <- as.data.frame(SP) 

#git config --global user.email "ceci_luzan@hotmail.com"

#git config --global user.email "ceci_luzan@hotmail.com"
#git config --global user.name "ceci1luzan"

SP.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()