library(edgeR)
library(Rsubread)
options(scipen=999)

data<-featureCounts(c(
"HL-60_ActD/Aligned.sortedByCoord.out.bam",
"HL-60_DMSO/Aligned.sortedByCoord.out.bam",
"HL-60_DRB/Aligned.sortedByCoord.out.bam"
),
annot.ext="/home/rtm/references/gencode.v28.annotation.gtf",
isGTFAnnotationFile=TRUE,
minMQS=4,
strandSpecific=0,
isPairedEnd=TRUE,
autosort=TRUE,
nthreads=20,
GTF.attrType="gene_name"
)

x <- DGEList(counts=data$counts, genes=data$annotation[,c("GeneID","Length")])
x_rpkm <- rpkm(x,x$genes$Length)

colnames(x_rpkm)=c("ActD","DMSO","DRB")

write.table(x_rpkm, "rpkm_wt_hl-60_all.txt",sep="\t",col.names=T,row.names=T,quote=F)
write.csv(x_rpkm, "rpkm_wt_hl-60_all.csv")
############################################################################################
tss = read.table("hg38_tss_knownCanonical.bed",sep="\t")
rpkm = read.table("rpkm_names.txt",sep="\t")
rpkm = as.character(rpkm[,1])
tss = tss[tss[,4] %in% rpkm,]
tss_num = table(tss[,4])
tss_num = tss_num[tss_num > 1]
tss_filtered = tss[!(tss[,4] %in% names(tss_num)), ]
write.table(tss_filtered,"hg38_tss_filteredbyRPKM.bed",quote=F,sep="\t",col.names=F,row.names=F)
############################################################################################
rpkm = read.csv("rpkm_wt_hl-60_all.csv",row.names=1)
tss = read.table("hg38_tss_filteredbyRPKM_sorted.bed",sep="\t",header=F,stringsAsFactors=F)

ix = match( tss[,4], rownames(rpkm))
rpkm = rpkm[ix,]

log_rpkm =asinh(rpkm)

postscript("RPKM_sortedBy_CHIPSEQ_Intensity.ps")
par(mfrow=c(3,1))
plot(log_rpkm[,2],ylim=c(0,9), xaxt='n',xlab="",yaxt='n',ylab=expression('Log'[2]*' RPKM') ,las=2,main="DMSO")#,type="l",lwd=11)
axis(side=2,labels = c(0,4,8) ,at=c(0,4,8),lwd.ticks=3,srt = 45, las = 2)

plot(log_rpkm[,1],ylim=c(0,9), xaxt='n',xlab="",yaxt='n',ylab=expression('Log'[2]*' RPKM') ,las=2,main="ActD")#,type="l",lwd=11)
axis(side=2,labels = c(0,4,8) ,at=c(0,4,8),lwd.ticks=3,srt = 45, las = 2)

plot(log_rpkm[,3],ylim=c(0,9), xaxt='n',xlab="",yaxt='n',ylab=expression('Log'[2]*' RPKM') ,las=2,main="DRB")#,type="l",lwd=11)
axis(side=2,labels = c(0,4,8) ,at=c(0,4,8),lwd.ticks=3,srt = 45, las = 2)
dev.off()

postscript("RPKM_sortedBy_RPKM_Intensity.ps")
par(mfrow=c(3,1))
plot(sort(log_rpkm[,2]),ylim=c(0,9), xaxt='n',xlab="",yaxt='n',ylab=expression('Log'[2]*' RPKM') ,las=2,main="DMSO")#,type="l",lwd=11)
axis(side=2,labels = c(0,4,8) ,at=c(0,4,8),lwd.ticks=3,srt = 45, las = 2)

plot(sort(log_rpkm[,1]),ylim=c(0,9), xaxt='n',xlab="",yaxt='n',ylab=expression('Log'[2]*' RPKM') ,las=2,main="ActD")#,type="l",lwd=11)
axis(side=2,labels = c(0,4,8) ,at=c(0,4,8),lwd.ticks=3,srt = 45, las = 2)

plot(sort(log_rpkm[,3]),ylim=c(0,9), xaxt='n',xlab="",yaxt='n',ylab=expression('Log'[2]*' RPKM') ,las=2,main="DRB")#,type="l",lwd=11)
axis(side=2,labels = c(0,4,8) ,at=c(0,4,8),lwd.ticks=3,srt = 45, las = 2)
dev.off()
