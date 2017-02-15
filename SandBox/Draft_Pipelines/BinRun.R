#!/usr/bin/Rscript

#FileName: Graphing_FittedModels.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph the results of 3 ld decay models

require(reshape2)
args = commandArgs(trailingOnly = TRUE)

#Trying to bin ld data
LD_Data<-read.table(args[1])

SplitVect<-seq(from = 0, to = 100000, by = 50)
BinMid<-seq(from = 25, to = 100000, by = 50)

BinAvg<-aggregate(LD_Data$V4, 
          list(cut(LD_Data$V3, breaks=SplitVect, right=FALSE)),
          mean)
if (length(BinMid)>length(BinAvg)){
  
}

sum_vect<-function(x,y){
  VecSum<-vector('numeric')
  #find the shorter vector than add on x number of zeros
  #x being the difference in length between the two 
  if (length(x)>length(y)){
    y<-c(y,rep(0, length = (length(x)-length(y))))
  }
  else{
    x<-c(x,rep(0, length = (length(y)-length(x))))
  }
  #add the now equal-length vectors
  VecSum<-x+y
  return(VecSum)
}

Col1<-seq(0, 1996, by =1)
Col2<-seq(0, 1996, by =1)
Col5<-seq(0, 1996, by =1)
Col6<-seq(0, 1996, by =1)
Col7<-seq(0, 1996, by =1)
OutPut<-data.frame(Col1, Col2, BinMid, BinAvg[2], Col5, Col6, Col7)
write.table(OutPut, file="BinRun2.csv", col.names = F, row.names = F)
