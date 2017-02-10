#!/usr/bin/Rscript

#FileName: Graphing_FittedModels.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph the results of 3 ld decay models

require(ggplot2)
require(tools)

args = commandArgs(trailingOnly = TRUE)
FileName <- basename(file_path_sans_ext(args[2]))
Path<-dirname(args[2])

# Import ld data
LD_Data <- read.table(args[1])
Distance <- LD_Data[,3]
R2 <- LD_Data[,4]

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
FitPlot<-ggplot(LD_Data, aes(x=Distance, y=R2)) + geom_point()
FitPlot<-FitPlot + try(stat_function(fun=function(x) init * exp(-lam * x), geom="line", aes(colour="EXP")), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) exp(-x * k) * x^t, geom="line", aes(colour="GAM")), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) a*x^2 + b*x + c, geom="line", aes(colour="POLY")), silent = T)

#Save to jpg
jpeg(file=paste(Path,"/",FileName,"_ModelPlot.jpg", sep = ""))
print(FitPlot)
dev.off()



