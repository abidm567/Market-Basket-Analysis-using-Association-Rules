
install.packages("Matrix")
install.packages("arules")
install.packages("arulesViz")
install.packages("readxl")

library("Matrix")
library("arules")
library("arulesViz")
library("readxl")
library(dplyr)


trs <- read_excel("IMB575-XLS-ENG.xls") #Reading the Transaction data of Bigbasket which is 'Single' data format.
glimpse(trs) #EDA
class(trs)


#Selecting a particular user to recommend products based on the user's purchase history
marketbasketcsv_member<-subset(trs,select=c("Member","Description"))
M43831<- filter(marketbasketcsv_member, Member == 'M43831')
M43831
write.csv(M43831,"/Individual Assignment/M43831.csv")


M43831_transactions <- read.transactions("Individual Assignment/M43831.csv", format = "single", sep=",",cols = c(2,3))
inspect(M43831_transactions)
summary(M43831_transactions)

rules_M43831 = apriori(M43831_transactions, parameter=list(support=0.50,confidence=0.6,minlen=3,maxlen=3)) #Setting the Support, Confidence criteria.
rules_M43831
inspect(rules_M43831)
top20rules <- head(rules_M43831, n = 20, by = "lift")
inspect(top20rules)
plot(top20rules, method = "graph",  engine = "htmlwidget")
#These rules can be utilised for product recommendations for cross-selling, user profiling.  
