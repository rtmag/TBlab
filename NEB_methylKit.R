library(methylKit)

file.list=list( "HCT116.Decitabine.WGBS.run1.1_bismark_bt2_pe.CpG_report.txt",                
                "HCT116.Decitabine.WGBS.run2.1_bismark_bt2_pe.CpG_report.txt",
                "HCT116.control.WGBS.run1.1_bismark_bt2_pe.CpG_report.txt",
                "HCT116.control.WGBS.run2.1_bismark_bt2_pe.CpG_report.txt" )


# read the files to a methylRawList object: myobj
myobj=methRead(file.list,
           sample.id=list("decitabine1","decitabine2","control1","control2"),
           assembly="hg38",
           treatment=c(1,1,0,0),
           context="CpG",
           pipeline="bismarkCytosineReport",
           header=FALSE,
           mincov=1)

meth=unite(myobj, destrand=TRUE,mc.cores=40)

#Pooled
pooled.meth=pool(meth,sample.ids=c("decitabine","control"))
pooled.meth=filterByCoverage(pooled.meth,lo.count=3)
pooled.myDiff=calculateDiffMeth(pooled.meth,num.cores=40)


# Calculate Differential methylation
cov.meth=filterByCoverage(meth,lo.count=5)
cov.myDiff=calculateDiffMeth(cov.meth,num.cores=40)
#

###FISHER

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

pooledData=getData(pooled.meth.cov)
fisher_neb=data.frame(pooled.myDiff,decitabine=(pooledData[,6]/pooledData[,5]),control=(pooledData[,9]/pooledData[,8]) ) 
write.table(fisher_neb,"fisher_neb.txt",quote=F,row.names=F,col.names=F,sep="\t")

