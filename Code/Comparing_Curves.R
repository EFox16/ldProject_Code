#!/usr/bin/Rscript

#FileName: Comparing_Curves.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph the best fit curves for the three scenarios and 2 real data sets on one plot

##IMPORTS
require(ggplot2)
require(tools)

#Read in a file to create the axis from
Axis_Data<-read.table("../Results/TSI/TSI_Bin.csv")
Distance <- Axis_Data[,3]/100000
R2 <- Axis_Data[,4]

#Read in TSI params
T_Data<-read.csv("../Results/TSI/TSI_Bin_FitParams.csv")
T_a<-T_Data[15,3]
T_b<-T_Data[16,3]
T_c<-T_Data[17,3]
T_d<-T_Data[18,3]

#Read in LWK params
L_Data<-read.csv("../Results/LWK/LWK_Bin_FitParams.csv")
L_a<-L_Data[15,3]
L_b<-L_Data[16,3]
L_c<-L_Data[17,3]
L_d<-L_Data[18,3]

#Read in constant scenario params
C_Data<-read.csv("../Results/Constant/Constant_Bin_FitParams.csv")
C_a<-C_Data[15,3]
C_b<-C_Data[16,3]
C_c<-C_Data[17,3]
C_d<-C_Data[18,3]

#Read in expanding scenario params
E_Data<-read.csv("../Results/Expand/Expand_Bin_FitParams.csv")
E_a<-E_Data[15,3]
E_b<-E_Data[16,3]
E_c<-E_Data[17,3]
E_d<-E_Data[18,3]

#Read in bottleneck scenario params
B_Data<-read.csv("../Results/Bottleneck/Bottleneck_Bin_FitParams.csv")
B_a<-B_Data[15,3]
B_b<-B_Data[16,3]
B_c<-B_Data[17,3]
B_d<-B_Data[18,3]

#Plot the axis
FitPlot<-ggplot(Axis_Data, aes(x=Distance, y=R2)) + geom_blank()
#Add in each of the curves
FitPlot<-FitPlot + try(stat_function(fun=function(x) T_a + T_b*x + T_c*x^2 + T_d*x^3, geom="line", aes(colour="European"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) L_a + L_b*x + L_c*x^2 + L_d*x^3, geom="line", aes(colour="African"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) C_a + C_b*x + C_c*x^2 + C_d*x^3, geom="line", aes(colour="Constant"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) E_a + E_b*x + E_c*x^2 + E_d*x^3, geom="line", aes(colour="Expand"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) B_a + B_b*x + B_c*x^2 + B_d*x^3, geom="line", aes(colour="Bottleneck"), size=1.5), silent = T)
FitPlot<-FitPlot + scale_colour_manual(values=c("orange", "blue", "dark blue", "red", "purple"))
pdf("../Results/Fitted_Graphs/Comparison_ModelPlot.pdf")
print(FitPlot)
dev.off()

