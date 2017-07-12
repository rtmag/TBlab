
myobj=methRead(file.list,
           sample.id=list("decitabine1","decitabine2","control1","control2"),
           assembly="hg38",
           treatment=c(1,1,0,0),
           context="CpG",
           pipeline="bismarkCytosineReport",
           header=FALSE,
           mincov=1)
meth=unite(myobj, destrand=TRUE,mc.cores=40)

pooled.meth=pool(meth,sample.ids=c("decitabine","control"))
pooled.meth.cov=pooled.meth[as.logical(rowSums(getData(pooled.meth)[,c(5,8)]>5)),]
pooled.myDiff=calculateDiffMeth(pooled.meth.cov,num.cores=40)
 res=methSeg(pooled.myDiff,diagnostic.plot=TRUE,maxInt=100,minSeg=10)




pooledData=getData(pooled.meth.cov)
fisher_neb=data.frame(pooled.myDiff,decitabine=(pooledData[,6]/pooledData[,5]),control=(pooledData[,9]/pooledData[,8]) ) 

####################################################
library(methylKit)

file.list=list( "HCT116.Decitabine.WGBS.run1.1_bismark_bt2_pe.CpG_report.txt",                
                "HCT116.Decitabine.WGBS.run2.1_bismark_bt2_pe.CpG_report.txt",
                "HCT116.control.WGBS.run1.1_bismark_bt2_pe.CpG_report.txt",
                "HCT116.control.WGBS.run2.1_bismark_bt2_pe.CpG_report.txt" )

myobj=methRead(file.list,
           sample.id=list("decitabine1","decitabine2","control1","control2"),
           assembly="hg38",
           treatment=c(1,1,0,0),
           context="CpG",
           pipeline="bismarkCytosineReport",
           header=FALSE,
           mincov=1)

tiles=tileMethylCounts(myobj,win.size=1000,step.size=1000,mc.cores = 40)

meth=unite(tiles, destrand=TRUE,mc.cores=40)

pooled.meth=pool(meth,sample.ids=c("decitabine","control"))
pooled.meth.cov=pooled.meth[as.logical(rowSums(getData(pooled.meth)[,c(5,8)]>5)),]
pooled.myDiff=calculateDiffMeth(pooled.meth.cov,num.cores=40)
#

pooledData=getData(pooled.meth.cov)
fisher_neb=data.frame(pooled.myDiff,decitabine=(pooledData[,6]/pooledData[,5]),control=(pooledData[,9]/pooledData[,8]) ) 
write.table(fisher_neb,"fisher_neb.txt",quote=F,row.names=F,col.names=F,sep="\t")


####

library("bsseq")


file.list=c( "HCT116.Decitabine.WGBS.run1.1_bismark_bt2_pe.bismark.cov.gz",                
                "HCT116.Decitabine.WGBS.run2.1_bismark_bt2_pe.bismark.cov.gz",
                "HCT116.control.WGBS.run1.1_bismark_bt2_pe.bismark.cov.gz",
                "HCT116.control.WGBS.run2.1_bismark_bt2_pe.bismark.cov.gz" )


BS.cancer.ex=read.bismark(file.list,
                  c("decitabine1","decitabine2","control1","control2"),
                  rmZeroCov = TRUE,
                  strandCollapse = FALSE,
                  fileType = "cov",
                  mc.cores = 40)

pData(BS.cancer.ex)=data.frame(Type=c("dec","dec","ctr","ctr"),stringsAsFactors=F)
rownames(pData(BS.cancer.ex))=c("dec1","dec2","ctr1","ctr2")

BS.cancer.ex.fit <- BSmooth(BS.cancer.ex, mc.cores = 40, verbose = TRUE)
BS.cov <- getCoverage(BS.cancer.ex.fit)
keepLoci.ex <- which(rowSums(BS.cov[, BS.cancer.ex$Type == "dec"] >= 2) >= 2 & 
                      rowSums(BS.cov[, BS.cancer.ex$Type == "ctr"] >= 2) >= 2)

BS.cancer.ex.fit <- BS.cancer.ex.fit[keepLoci.ex,]

BS.cancer.ex.tstat <- BSmooth.tstat(BS.cancer.ex.fit, 
                                    group1 = c("dec1","dec2"),
                                    group2 = c("ctr1","ctr2"),
                                    estimate.var = "same",
                                    local.correct = TRUE,
                                    verbose = TRUE)

dmrs0 <- dmrFinder(BS.cancer.ex.tstat, cutoff = c(-4.6, 4.6))
dmrs <- subset(dmrs0, n >= 3 & abs(meanDiff) >= 0.1)
nrow(dmrs)
head(dmrs, n = 3)

head(getStats(BS.cancer.ex.tstat))
##
BS.cancer.ex.fit <- BSmooth(BS.cancer.ex, mc.cores = 40, verbose = TRUE)
results <- fisherTests(BStest, group1 = c("dec1","dec2"), group2 = c("ctr1","ctr2"), returnLookup = TRUE)
results



