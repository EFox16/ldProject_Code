#!/usr/bin/Rscript

#FileName: Plotting_Scenario_Curves.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph the results of 3 ld decay models

require(ggplot2)
require(tools)

Axis_Data<-read.table("TSI/TSI_Bin.csv")
Distance <- Axis_Data[,3]/100000
R2 <- Axis_Data[,4]

T_Data<-read.csv("TSI/TSI_Bin_FitParams.csv")
T_a<-T_Data[10,3]
T_b<-T_Data[11,3]
T_c<-T_Data[12,3]
T_d<-T_Data[13,3]

L_Data<-read.csv("LWK/LWK_Bin_FitParams.csv")
L_a<-L_Data[10,3]
L_b<-L_Data[11,3]
L_c<-L_Data[12,3]
L_d<-L_Data[13,3]

C_Data<-read.csv("Constant/Constant_Bin_FitParams.csv")
C_a<-C_Data[10,3]
C_b<-C_Data[11,3]
C_c<-C_Data[12,3]
C_d<-C_Data[13,3]

E_Data<-read.csv("Expand/Expand_Bin_FitParams.csv")
E_a<-E_Data[10,3]
E_b<-E_Data[11,3]
E_c<-E_Data[12,3]
E_d<-E_Data[13,3]

B_Data<-read.csv("Bottleneck/Bottleneck_Bin_FitParams.csv")
B_a<-B_Data[10,3]
B_b<-B_Data[11,3]
B_c<-B_Data[12,3]
B_d<-B_Data[13,3]

FitPlot<-ggplot(Axis_Data, aes(x=Distance, y=R2)) + geom_blank()
FitPlot<-FitPlot + try(stat_function(fun=function(x) T_a + T_b*x + T_c*x^2 + T_d*x^3, geom="line", aes(colour="TSI"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) L_a + L_b*x + L_c*x^2 + L_d*x^3, geom="line", aes(colour="LWK"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) C_a + C_b*x + C_c*x^2 + C_d*x^3, geom="line", aes(colour="CONSTANT"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) E_a + E_b*x + E_c*x^2 + E_d*x^3, geom="line", aes(colour="EXPAND"), size=1.5), silent = T)
FitPlot<-FitPlot + try(stat_function(fun=function(x) B_a + B_b*x + B_c*x^2 + B_d*x^3, geom="line", aes(colour="BOTTLENECK"), size=1.5), silent = T)
jpeg("5Scenario_ModelPlot.jpg")
print(FitPlot)
dev.off()

