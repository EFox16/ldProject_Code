#!/usr/bin/Rscript

#FileName: Graphing_FittedModels.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph the results of 3 ld decay models

require(ggplot2)
require(tools)

args = commandArgs(trailingOnly = TRUE)
FileName <- basename(file_path_sans_ext(args[2]))
Path<-"../Fitted_Graphs"

# Import ld data
LD_Data <- read.table(args[1])
Distance <- LD_Data[,3]/100000
R2 <- LD_Data[,4]

# Import parameters from the fit curves
Model_Data <- read.csv(args[2])
init<-Model_Data[1,3]
lam<-Model_Data[2,3]
k<-Model_Data[3,3]
t<-Model_Data[4,3]
a1<-Model_Data[5,3]
b1<-Model_Data[6,3]
a2<-Model_Data[7,3]
b2<-Model_Data[8,3]
c2<-Model_Data[9,3]
a3<-Model_Data[10,3]
b3<-Model_Data[11,3]
c3<-Model_Data[12,3]
d3<-Model_Data[13,3]


#Plot the three curves
FitPlot<-ggplot(LD_Data, aes(x=Distance, y=R2)) + geom_point()
FitPlot<-FitPlot + try(stat_function(fun=function(x) init * exp(-lam * x), geom="line", aes(colour="EXP"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) exp(-x * k) * x^t, geom="line", aes(colour="GAM"), size=1.5), silent = T) 
FitPlot<-FitPlot + try(stat_function(fun=function(x) a1 + b1*x, geom="line", aes(colour="POLY1"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) a2 + b2*x + c2*x^2, geom="line", aes(colour="POLY2"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) a3 + b3*x + c3*x^2 + d3*x^3, geom="line", aes(colour="POLY3"), size=1.5), silent = T)

#Save to jpg
jpeg(file=paste(Path,"/",FileName,"_ModelPlot.jpg", sep = ""))
print(FitPlot)
dev.off()