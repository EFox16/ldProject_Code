#FileName: Graphing.R
#Author: "Emma Fox (e.fox16@imperial.ac.uk)"
#Used to graph pipeline 1 output

library(tools)

args = commandArgs(trailingOnly = TRUE)
argsName <- basename(file_path_sans_ext(args[1]))

reads_data <- read.table(args[1])
pdf(paste(argsName,"_plot.pdf", sep = ""))
print(plot(reads_data[,3], reads_data[,4]))
dev.off()

