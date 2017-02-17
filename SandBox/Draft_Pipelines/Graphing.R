#FileName: Graphing.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph pipeline 1 output

args = commandArgs(trailingOnly = TRUE)

library(tools)
FileName <- basename(args[1])

LD_data <- read.table(args[1])
jpeg(file=paste(FileName,"_LDPlot.jpg", sep = ""))
plot(LD_data[,3], LD_data[,4])
dev.off()

