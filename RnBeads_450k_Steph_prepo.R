print("############################### INIT")
suppressMessages(suppressWarnings(library(RnBeads)))
#IN
args <- commandArgs(trailingOnly = TRUE)
c.dir <- args[1]
print(c.dir)

# Multiprocess
num.cores <- 23
parallel.setup(num.cores)
## prepro
pipe.input <- paste("../samples/",gsub(".+/","",c.dir,perl=TRUE),"/DNA_Methylation/JHU_USC__HumanMethylation450/Level_1/",sep="")
pipe.input <-gsub("//","/",pipe.input,perl=TRUE)
idat.dir <- file.path(pipe.input)
print(idat.dir)

pipe.input <- paste(c.dir,"/sample.annotation.txt",sep="")
pipe.input <-gsub("//","/",pipe.input,perl=TRUE)
if ( file.exists(pipe.input)){
	sample.annotation <- file.path(pipe.input)
	print(sample.annotation)

	pipe.input <- paste("mkdir ",c.dir,"/rnbeads_analysis/",sep="")
	pipe.input <-gsub("//","/",pipe.input,perl=TRUE)
	system(pipe.input)
	print(pipe.input)
	
	pipe.input <- paste(c.dir,"/rnbeads_analysis/",sep="")
	pipe.input <-gsub("//","/",pipe.input,perl=TRUE)
	report.dir <- file.path(pipe.input)
	print(report.dir)

	rnb.options(import.table.separator="\t")
	data.source <- c(idat.dir, sample.annotation)
	result <- rnb.run.import(data.source=data.source,data.type="infinium.idat.dir", dir.reports=report.dir)
	rnb.set.norm <- rnb.execute.normalization(result$rnb.set, method="swan",bgcorr.method="methylumi.noob")

	pipe.input <- paste("/home/roberto/TCGA/preprocessing_tp53/",gsub(".+/","",c.dir,perl=TRUE),"/rnb.set.norm.RData",sep="")
	pipe.input <-gsub("//","/",pipe.input,perl=TRUE)
	print(pipe.input)
	save.rnb.set(rnb.set.norm,path=pipe.input)
	print(pipe.input)

}else{ print("No Sample Annotation File")
}
print("############################### END")
rm(list=ls())
