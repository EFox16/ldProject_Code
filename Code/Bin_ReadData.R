#!/usr/bin/Rscript

#FileName: Graphing_FittedModels.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph the results of 3 ld decay models

require(reshape2)
require(tools)
args = commandArgs(trailingOnly = TRUE)

#Trying to bin ld data
LD_Data<-read.table(args[1])
FileName <- basename(file_path_sans_ext(args[1]))
Path<-dirname(args[2])

SplitVect<-seq(from = 0, to = 100000, by = 50)

ListAvg<-aggregate(LD_Data$V4, 
          list(cut(LD_Data$V3, breaks=SplitVect, right=FALSE)),
          mean)
BinAvg<-as.vector(ListAvg$x)
BinMid<-seq(from = 25, by = 50, length.out = length(BinAvg))

Col1<-rep(0, length.out = (length(BinAvg)))
Col2<-rep(0, length.out = (length(BinAvg)))
Col5<-rep(0, length.out = (length(BinAvg)))
Col6<-rep(0, length.out = (length(BinAvg)))
Col7<-rep(0, length.out = (length(BinAvg)))

OutPut<-data.frame(Col1, Col2, BinMid, BinAvg, Col5, Col6, Col7)
write.table(OutPut, file=paste(FileName,"_Bin.csv", sep = ""), col.names = F, row.names = F)
