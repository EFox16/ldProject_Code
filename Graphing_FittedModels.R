#FileName: Graphing_FittedModels.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph the results of 3 ld decay models

require(ggplot2)
library(tools)

args = commandArgs(trailingOnly = TRUE)
FileName <- basename(file_path_sans_ext(args[2]))

# Import ld data
LD_data <- read.table("Constant_Results/Constant_reads.testLD.ld")
Distance <- LD_data[,3]
R2 <- LD_data[,4]

# Import parameters from the fit curves
Model_Data <- read.csv(args[2])
init<-Model_Data[1,3]
lam<-Model_Data[2,3]
k<-Model_Data[3,3]
t<-Model_Data[4,3]
a<-Model_Data[5,3]
b<-Model_Data[6,3]
c<-Model_Data[7,3]

#Plot the three curves
jpeg(file=paste(FileName,"_ModelPlot.jpg", sep = ""))
ggplot(LD_data, aes(x=Distance, y=R2)) + geom_point() + 
  stat_function(fun=function(x) init * exp(-lam * x), geom="line", aes(colour="EXP")) +
  stat_function(fun=function(x) exp(-x * k) * x^t, geom="line", aes(colour="GAM")) +
  stat_function(fun=function(x) a*x^2 + b*x + c, geom="line", aes(colour="POLY")) 
dev.off()



