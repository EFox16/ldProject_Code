#FileName: Graphing_FittedModels.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph the results of 3 ld decay models

require(ggplot2)
library(tools)

# args = commandArgs(trailingOnly = TRUE)
# FileName <- basename(args[1])
# 
# LD_data <- read.table(args[1])
# jpeg(file=paste(FileName,"_LDPlot.jpg", sep = ""))
# plot(LD_data[,3], LD_data[,4])
# dev.off()

mydata=read.csv("Constant_Results/Constant_reads.testLD.ld_FitParams.csv")

init<-mydata[1,3]
lam<-mydata[2,3]
k<-mydata[3,3]
t<-mydata[4,3]
a<-mydata[5,3]
b<-mydata[6,3]
c<-mydata[7,3]

y <- init * exp(-lam * x)
y <- exp(-x * k) * x^t
y <- a*x^2 + b*x + c
  
LD_data <- read.table("Constant_Results/Constant_reads.testLD.ld")
Distance <- LD_data[,3]
R2 <- LD_data[,4]

ggplot(LD_data, aes(x=Distance, y=R2)) + geom_point() + 
  stat_function(fun=function(x) init * exp(-lam * x), geom="line", aes(colour="EXP")) +
  stat_function(fun=function(x) exp(-x * k) * x^t, geom="line", aes(colour="GAM")) +
  stat_function(fun=function(x) a*x^2 + b*x + c, geom="line", aes(colour="POLY")) 
         
         
         
         
         
         