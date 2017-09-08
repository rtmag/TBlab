
beta <- read.csv("ptdlbcl-beta-values.csv",row.names=1,stringsAsFactors=F)
colnames(beta)<-gsub("X","",colnames(beta))

sample=read.csv("sample_ano.csv",stringsAsFactors=F)
sample=sample[1:35,]
sample[,1]=gsub("beta.","",sample[,1])
sample=sample[order(sample[,1]),]

beta=beta[,which(colnames(beta) %in% sample[,1])]
beta=beta[complete.cases(beta),]


colors <- colorRampPalette( (brewer.pal(9, "Blues")) )(255)
cols=brewer.pal(3, "Set1")


# set the custom distance and clustering functions
hclustfunc <- function(x) hclust(x, method="complete")
distfunc <- function(x) dist(x, method="euclidean")

#####################
EBV=as.character(sample$EBV)
EBV[EBV=='POS']=1
EBV[EBV=='neg']=2
EBV=as.numeric(EBV)

Disease=as.character(sample$Disease)
Disease[Disease=='PTLD']=1
Disease[Disease=='IC-DLBCL']=2
Disease=as.numeric(Disease)

cEBV=c("green","red")
cDisease=c("blue","orange")
clab=cbind(cEBV[EBV],cDisease[Disease])
colnames(clab)=c("EBV","Disease")

#remove 0 var

beta_var=beta[complete.cases(beta),]
#
tiff("Annalissa_unsupervisedClustering.tiff",width = 8, height = 7, units = "in", res = 1200)
x=heatmap.3(beta_var,col=colors, hclustfun=hclustfunc, distfun=distfunc, 
            scale="none", trace="none",cexCol=0.2,KeyValueName="Methylation Level",
             ColSideColors=clab,dendrogram="both",labRow=FALSE, labCol = FALSE)

legend("topleft",legend=c("EBV POS","EBV NEG","PTLD","IC-DLBCL"),fill=c("green","red","blue","orange"), border=T, bty="n", y.intersp = 0.7, cex=0.5,inset=c(0,.15))

dev.off()


##############

ir.pca <- prcomp((beta_var),
                 center = TRUE,
scale. = TRUE) 

sx=summary(ir.pca)

pdf("PCAs.pdf")
plot(ir.pca$x[,1],ir.pca$x[,2],col=cDisease,xlab=paste("PCA1:",sx$importance[2,1]),ylab=paste("PCA2:",sx$importance[2,2]))
legend("topright",legend=c("PTLD","IC-DLBCL"),fill=c("blue","orange"), border=T, bty="n" )

plot(ir.pca$x[,1],ir.pca$x[,2],col=cEBV,xlab=paste("PCA1:",sx$importance[2,1]),ylab=paste("PCA2:",sx$importance[2,2]))
legend("topright",legend=c("EBV POS","EBV NEG"),fill=c("green","red"), border=T, bty="n" )
dev.off()


###
beta_EBV_qval=apply(beta,1,function(x) wilcox.test(as.numeric(x[sample$EBV=='POS']),as.numeric(x[sample$EBV=='neg']))$p.value)
beta_EBV_qval=qvalue(beta_EBV_qval)$qvalues
                    
beta_EBV_methdiff=apply(beta,1,function(x){ mean(x[sample$EBV=='POS']) - mean(x[sample$EBV=='neg']) } )


                     
beta_swx=beta[beta_EBV_qval<0.05 & abs(beta_EBV_methdiff)>.2,]
beta_swx=beta_swx[complete.cases(beta_swx),]

#555        
tiff("Annalissa_EBV_fdr5_methdiff20_555.tiff",width = 8, height = 7, units = "in", res = 1200)
x=heatmap.3(beta_swx,col=colors, hclustfun=hclustfunc, distfun=distfunc, 
            scale="none", trace="none",cexCol=0.2,KeyValueName="Methylation Level",
             ColSideColors=clab,dendrogram="both",labRow=FALSE, labCol = FALSE)
                    legend("topleft",legend=c("EBV POS","EBV NEG","PTLD","IC-DLBCL"),fill=c("green","red","blue","orange"), border=T, bty="n", y.intersp = 0.7, cex=0.5,inset=c(0,.15))

dev.off()
             
########################

beta_Disease_qval=apply(beta,1,function(x) wilcox.test(as.numeric(x[sample$Disease=='PTLD']),as.numeric(x[sample$Disease=='IC-DLBCL']))$p.value)
beta_Disease_qval=qvalue(beta_Disease_qval)$qvalues
                    
beta_Disease_methdiff=apply(beta,1,function(x){ mean(x[sample$Disease=='PTLD']) - mean(x[sample$Disease=='IC-DLBCL']) } )


                     
beta_swx=beta[beta_Disease_qval<0.05 & abs(beta_Disease_methdiff)>.2,]
beta_swx=beta_swx[complete.cases(beta_swx),]

#222
tiff("Annalissa_disease_fdr5_methdiff20_222.tiff",width = 8, height = 7, units = "in", res = 1200)
x=heatmap.3(beta_swx,col=colors, hclustfun=hclustfunc, distfun=distfunc, 
            scale="none", trace="none",cexCol=0.2,KeyValueName="Methylation Level",
             ColSideColors=clab,dendrogram="both",labRow=FALSE, labCol = FALSE)
legend("topleft",legend=c("EBV POS","EBV NEG","PTLD","IC-DLBCL"),fill=c("green","red","blue","orange"), border=T, bty="n", y.intersp = 0.7, cex=0.5,inset=c(0,.15))

                        dev.off()
              
 ############
beta_swx=beta[(beta_Disease_qval<0.05 | beta_EBV_qval<0.05) & abs(beta_EBV_methdiff)>.2,]

tiff("Annalissa_both_fdr5_methdiff20_570.tiff",width = 8, height = 7, units = "in", res = 1200)
x=heatmap.3(beta_swx,col=colors, hclustfun=hclustfunc, distfun=distfunc, 
            scale="none", trace="none",cexCol=0.2,KeyValueName="Methylation Level",
             ColSideColors=clab,dendrogram="both",labRow=FALSE, labCol = FALSE)
legend("topleft",legend=c("EBV POS","EBV NEG","PTLD","IC-DLBCL"),fill=c("green","red","blue","orange"), border=T, bty="n", y.intersp = 0.7, cex=0.5,inset=c(0,.15))

                        dev.off()
              
                        
                        
     beta_swx)                   
                        
