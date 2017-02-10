require(reshape2)

#Trying to bin ld data
LD_Data<-read.table("Constant_Results/Constant_reads.testLD.ld")

SplitVect<-seq(from = 0, to = 100000, by = 50)

BinMid<-seq(from = 25, to = 99850, by = 50)

BinAvg<-aggregate(LD_Data$V4, 
          list(cut(LD_Data$V3, breaks=SplitVect, right=FALSE)),
          mean)

Col1<-seq(0, 1996, by =1)
Col2<-seq(0, 1996, by =1)
Col5<-seq(0, 1996, by =1)
Col6<-seq(0, 1996, by =1)
Col7<-seq(0, 1996, by =1)
OutPut<-data.frame(Col1, Col2, BinMid, BinAvg[2], Col5, Col6, Col7)
write.table(OutPut, file="BinRun2.csv", col.names = F, row.names = F)
