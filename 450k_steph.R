

library(RnBeads)
rnb.set.norm=load.rnb.set("rnb.set.norm.RData.zip")

rnb.set.norm@pheno=data.frame(rnb.set.norm@pheno, 
                              Time=c("0","12","24","48","0","12","24","48","0","12","48","ctrl",
                                     "0","12","24","48","0","12","24","48","0","12","48","ctrl"),
                              reps=c("wt_0","wt_12","wt_24","wt_48","p53_0","p53_12","p53_24","p53_48",
                                    "dnmt1_0","dnmt1_12","dnmt1_48","ctrl",
                                    "wt_0","wt_12","wt_24","wt_48","p53_0","p53_12","p53_24","p53_48",
                                    "dnmt1_0","dnmt1_12","dnmt1_48","ctrl")
                             )

WT_VS_TP53_0h=remove.samples(rnb.set.norm,samples(rnb.set.norm)[c(2:4,6:12,14:16,18:24)] )
WT_VS_TP53_0h_dmr <- rnb.execute.computeDiffMeth(WT_VS_TP53_0h,pheno.cols=c("reps"))


WT_VS_TP53_48h=remove.samples(rnb.set.norm,samples(rnb.set.norm)[c(1:3,5:7,9:15,17:19,21:24)] )
WT_VS_TP53_48h_dmr <- rnb.execute.computeDiffMeth(WT_VS_TP53_48h,pheno.cols=c("reps"))


comparison <- get.comparisons(WT_VS_TP53_0h_dmr)[1]
WT_VS_TP53_0h_dmr_table <-get.table(WT_VS_TP53_0h_dmr, comparison, "sites", return.data.frame=TRUE)
comparison <- get.comparisons(WT_VS_TP53_48h_dmr)[1]
WT_VS_TP53_48h_dmr_table <-get.table(WT_VS_TP53_48h_dmr, comparison, "sites", return.data.frame=TRUE)

meth.norm<-meth(rnb.set.norm)
colnames(meth.norm)=rnb.set.norm@pheno$reps
#
x=which(abs(WT_VS_TP53_0h_dmr_table$mean.diff)>.25 & WT_VS_TP53_0h_dmr_table$diffmeth.p.adj.fdr<0.05)

colors <- colorRampPalette( (brewer.pal(9, "Blues")) )(255)
cols=brewer.pal(3, "Set1")

# set the custom distance and clustering functions
hclustfunc <- function(x) hclust(x, method="complete")
distfunc <- function(x) dist(x, method="euclidean")

tiff("WT_VS_TP53_0h.tiff",width = 8, height = 7, units = "in", res = 1200)
y=heatmap.2(meth.norm[x,c(4,8,11,16,20,23)],col=colors, hclustfun=hclustfunc, distfun=distfunc, 
            scale="none", trace="none",cexCol=0.7,KeyValueName="Methylation Level",
            dendrogram="both",labRow=FALSE)
dev.off()
  hc <- as.hclust( y$rowDendrogram )
groups=cutree( hc, k=2 )
  
  probe.annotation <- rnb.get.annotation("probes450")
  probe.annotation@unlistData[x,][groups==1]
  probe.annotation@unlistData[x,][groups==2]
  
  gr=probe.annotation@unlistData[x,][groups==1]
  gr=data.frame(seqnames=seqnames(gr),
  starts=start(gr)-250,
  ends=end(gr)+250,
  names=c(rep(".", length(gr))),
  scores=c(rep(".", length(gr))),
  strands=strand(gr))
 write.table(gr,"WT_VS_TP53_0h_hypoWT.bed",quote=F,row.names=F,col.names=F,sep="\t") 
  
  gr=probe.annotation@unlistData[x,][groups==2]
  gr=data.frame(seqnames=seqnames(gr),
  starts=start(gr)-250,
  ends=end(gr)+250,
  names=c(rep(".", length(gr))),
  scores=c(rep(".", length(gr))),
  strands=strand(gr))
  write.table(gr,"WT_VS_TP53_0h_hyperWT.bed",quote=F,row.names=F,col.names=F,sep="\t") 

  
#####
  
x=which(abs(WT_VS_TP53_48h_dmr_table$mean.diff)>.25 & WT_VS_TP53_48h_dmr_table$diffmeth.p.adj.fdr<0.05)

colors <- colorRampPalette( (brewer.pal(9, "Blues")) )(255)
cols=brewer.pal(3, "Set1")

# set the custom distance and clustering functions
hclustfunc <- function(x) hclust(x, method="complete")
distfunc <- function(x) dist(x, method="euclidean")

tiff("WT_VS_TP53_48h.tiff",width = 8, height = 7, units = "in", res = 1200)
y=heatmap.2(meth.norm[x,c(4,8,11,16,20,23)],col=colors, hclustfun=hclustfunc, distfun=distfunc, 
            scale="none", trace="none",cexCol=0.7,KeyValueName="Methylation Level",
            dendrogram="both",labRow=FALSE)
dev.off()
  hc <- as.hclust( y$rowDendrogram )
groups=cutree( hc, k=2 )
  
  probe.annotation <- rnb.get.annotation("probes450")
  probe.annotation@unlistData[x,][groups==1]
  probe.annotation@unlistData[x,][groups==2]
  
  gr=probe.annotation@unlistData[x,][groups==1 | groups==3]
  gr=data.frame(seqnames=seqnames(gr),
  starts=start(gr)-250,
  ends=end(gr)+250,
  names=c(rep(".", length(gr))),
  scores=c(rep(".", length(gr))),
  strands=strand(gr))
 write.table(gr,"WT_VS_TP53_48h_hypoWT.bed",quote=F,row.names=F,col.names=F,sep="\t") 
  
  gr=probe.annotation@unlistData[x,][groups==2]
  gr=data.frame(seqnames=seqnames(gr),
  starts=start(gr)-250,
  ends=end(gr)+250,
  names=c(rep(".", length(gr))),
  scores=c(rep(".", length(gr))),
  strands=strand(gr))
  write.table(gr,"WT_VS_TP53_48h_hyperWT.bed",quote=F,row.names=F,col.names=F,sep="\t") 
