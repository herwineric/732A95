# # # # # # # # #         
 #             # 
  #           # 
   # # # # # # 
   # Block 2 # 
   #  Lab 2  #
   # 732A95  # 
   # # # # # # 
  #           # 
 #             #
# # # # # # # # #            



## Assignment 2

library(tree)
library(mboost)
library(randomForest)

BFR <- read.csv2("B2lab2/bodyfatregression.csv")
set.seed(1234567890)
BFR <- BFR[sample(nrow(BFR), replace = FALSE),]


train <- BFR[1:floor((nrow(BFR)*(2/3))),]
test <- BFR[74:nrow(BFR),]

## 2.1 

# #Det h�r tror vi �r r�tt enligt formel 2 p� ppt 5/19 i slides b2fl1
# 
# bfr.SE <- 0
# set.seed(1234567890)
# for (i in 1:100) {
#   samptrain<-train[sample(nrow(train),replace = TRUE),] 
#   bfr.tree        <- tree(Bodyfat_percent ~. ,data = samptrain)
#   bfr.predictions <- predict(bfr.tree,test)
#   bfr.SE[i]       <- sum((bfr.predictions - test$Bodyfat_percent))
# }
# 
# mean((bfr.SE/100)^2) 

### Det h�r tror vi �r fel, men Caroline s�ger att det �r r�tt, och man ska lita p� labbass, hon hade r�tt
bfr.SE <- 0
set.seed(1234567890)
for (i in 1:100) {
  samptrain<-train[sample(nrow(train),replace = TRUE),] 
  bfr.tree        <- tree(Bodyfat_percent ~. ,data = samptrain)
  bfr.predictions <- predict(bfr.tree,test)
  bfr.SE[i]       <- mean((bfr.predictions - test$Bodyfat_percent)^2)
}
mean(bfr.SE) 
plot(bfr.SE) 


#Vafan g�r jag? 

# ## 2.2 
# bfr.SE2 <- c() 
# set.seed(1234567890)
# 
# bfr.tree22 <- tree(Bodyfat_percent ~. ,data = BFR)
# bfr.cv <- cv.tree(bfr.tree22, K = 3)
# best.size <- bfr.cv$size[which.min(bfr.cv$dev)]
# #bfr.tree22 <- prune.tree(bfr.tree22, best = best.size)
# 
# 
# 
# for (i in 1:100){ 
#   BFRre<- BFR[sample(nrow(BFR),replace = TRUE),]
#   bfr.tree22 <- tree(Bodyfat_percent ~. ,data = BFRre )
#   bfr.tree22 <- prune.tree(bfr.tree22, best = best.size)
#   bfr.SE2[i] <- mean( (predict(bfr.tree22, newdata = BFR) - BFR$Bodyfat_percent)^2) 
# } 
# 
# mean(bfr.SE2)
# 
# mean(  (bfr.SE2/100)^2)
# 
# #vilken data predictar jag p�? 
# summary(bfr.cv)
# plot(bfr.cv)
# predict(bfr.cv)

# �nnu en version


#fuck <- function(){



set.seed(1234567890)
BFR$index<-c(rep(1,36),rep(2,37),rep(3,37))
#BFR$index<-sample(c(rep(1,36),rep(2,37),rep(3,37)))
bfr.SE2<-matrix(nrow=100,ncol=3)
iter <- c()
subset(BFR,index != 1)[,c(-4)]

for (set in 1:3){
  BFRa<-subset(BFR,BFR$index != set)[,c(-4)]
  BFRpred<-subset(BFR,BFR$index == set)[,c(-4)]
  
  #print(c(nrow(BFRa),nrow(BFRpred),nrow(BFRa)+nrow(BFRpred)))
  for (i in 1:100){ 
    
    
    BFRre<- BFRa[sample(1:nrow(BFRa),replace = TRUE),]
    bfr.tree22 <- tree(Bodyfat_percent ~. ,data = BFRre, split = "deviance" )
    bfr.SE2[i,set] <- mean( (predict(bfr.tree22, newdata = BFRpred) - BFRpred$Bodyfat_percent)^2) 
    
    
  } 
} 

mean(bfr.SE2)

subset

## 2.3 

#Same for 2.1 and 2.2 but with all the data in 2.1. 





