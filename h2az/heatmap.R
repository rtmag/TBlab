h2az = read.table(pipe("grep -v -P '#|genes' h2azOnly_20bp_2kb_QNORM.rmat"),sep="\t")

ach2az = read.table(pipe("grep -v -P '#|genes' ach2azOnly_20bp_2kb_CPM.rmat"),sep="\t")
#########################################################################################################################
# 95% confidence interval
h2_DRB=colMeans(h2az)[1:200]
h2_ACTD=colMeans(h2az)[201:400]
h2_DMSO=colMeans(h2az)[401:600]

ac_DRB=colMeans(ach2az)[1:200]
ac_ACTD=colMeans(ach2az)[201:400]
ac_DMSO=colMeans(ach2az)[401:600]

h2_DRB_conf=apply(h2az[,1:200],2,function(x) t.test(x)$conf.int)
h2_ACTD_conf=apply(h2az[,201:400],2,function(x) t.test(x)$conf.int)
h2_DMSO_conf=apply(h2az[,401:600],2,function(x) t.test(x)$conf.int)

ac_DRB_conf=apply(ach2az[,1:200],2,function(x) t.test(x)$conf.int)
ac_ACTD_conf=apply(ach2az[,201:400],2,function(x) t.test(x)$conf.int)
ac_DMSO_conf=apply(ach2az[,401:600],2,function(x) t.test(x)$conf.int)

#
library(gplots)
library(ggplot2)
library(Cairo)

c.min=min(h2_DRB_conf,h2_ACTD_conf,h2_DMSO_conf)
c.max=max(h2_DRB_conf,h2_ACTD_conf,h2_DMSO_conf)

pdf("H2AZ_profile_95confInterval.pdf")
plot(h2_DRB,type="l",ylim=c(c.min,c.max),xaxt='n',xlab="",ylab="Quantile Normalized H2AZ ChIP-Seq Tags",col='#619CFF',lwd=3)
Axis(side=1, labels=c("-2 KB","TSS","2 KB"),at=c(1,97,200))
polygon( c(1:200,rev(c(1:200)) ),c(h2_DRB_conf[1,],rev(h2_DRB_conf[2,])), col = alpha('#619CFF',.3), border = NA)
lines(h2_ACTD,col="#F8766D",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(h2_ACTD_conf[1,],rev(h2_ACTD_conf[2,])), col = alpha('#F8766D',.3), border = NA)       
lines(h2_DMSO,col="#00BA38",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(h2_DMSO_conf[1,],rev(h2_DMSO_conf[2,])), col = alpha('#00BA38',.3), border = NA)
legend("topright", legend=c("DRB","ACTD","DMSO"), fill=c('#619CFF','#F8766D','#00BA38'), bty = "n",cex = 1.3)
abline(v=97,lty=2)
dev.off()
                   
c.min=min(ac_DRB_conf,ac_ACTD_conf,ac_DMSO_conf)
c.max=max(ac_DRB_conf,ac_ACTD_conf,ac_DMSO_conf)
   
svg("acH2AZ_profile_95confInterval.svg")
plot(ac_DRB,type="l",ylim=c(c.min,c.max),xaxt='n',xlab="",ylab="CPM Normalized acH2AZ ChIP-Seq Tags",col='#619CFF',lwd=3)
Axis(side=1, labels=c("-2 KB","TSS","2 KB"),at=c(1,97,200))
polygon( c(1:200,rev(c(1:200)) ),c(ac_DRB_conf[1,],rev(ac_DRB_conf[2,])), col = alpha('#619CFF',.3), border = NA)
lines(ac_ACTD,col="#F8766D",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(ac_ACTD_conf[1,],rev(ac_ACTD_conf[2,])), col = alpha('#F8766D',.3), border = NA)       
lines(ac_DMSO,col="#00BA38",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(ac_DMSO_conf[1,],rev(ac_DMSO_conf[2,])), col = alpha('#00BA38',.3), border = NA)
legend("topright", legend=c("DRB","ACTD","DMSO"), fill=c('#619CFF','#F8766D','#00BA38'), bty = "n",cex = 1.3)
abline(v=97,lty=2)
dev.off()
   

#########################################################################################################################
# ratio
                   
h2az_DRB = (h2az[,1:200])-(h2az[,401:600])
h2az_ACTD= (h2az[,201:400])-(h2az[,401:600])
                   
h2_DRB=colMeans(h2az_DRB)
h2_ACTD=colMeans(h2az_ACTD)
                   
h2_DRB_conf=apply(h2az_DRB,2,function(x) t.test(x)$conf.int)
h2_ACTD_conf=apply(h2az_ACTD,2,function(x) t.test(x)$conf.int)

c.min=min(h2_DRB_conf,h2_ACTD_conf)
c.max=max(h2_DRB_conf,h2_ACTD_conf)

#pdf("h2az_ratio.pdf")
plot(h2_DRB,type="l",ylim=c(c.min,c.max),xaxt='n',xlab="",ylab="Quantile Normalized H2AZ ChIP-Seq Tags",col='#619CFF',lwd=3)
Axis(side=1, labels=c("-2 KB","TSS","2 KB"),at=c(1,97,200))
polygon( c(1:200,rev(c(1:200)) ),c(h2_DRB_conf[1,],rev(h2_DRB_conf[2,])), col = alpha('#619CFF',.3), border = NA)
lines(h2_ACTD,col="#F8766D",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(h2_ACTD_conf[1,],rev(h2_ACTD_conf[2,])), col = alpha('#F8766D',.3), border = NA) 
legend("topright", legend=c("DRB/DMSO","ACTD/DMSO"), fill=c('#619CFF','#F8766D'), bty = "n",cex = 1.3)
                   abline(v=97,lty=2)

dev.off()

##########################
h2az_DRB = (ach2az[,1:200])-(ach2az[,401:600])
h2az_ACTD= (ach2az[,201:400])-(ach2az[,401:600])
                   
h2_DRB=colMeans(h2az_DRB)
h2_ACTD=colMeans(h2az_ACTD)
                   
h2_DRB_conf=apply(h2az_DRB,2,function(x) t.test(x)$conf.int)
h2_ACTD_conf=apply(h2az_ACTD,2,function(x) t.test(x)$conf.int)

c.min=min(h2_DRB_conf,h2_ACTD_conf)
c.max=max(h2_DRB_conf,h2_ACTD_conf)

pdf("ach2az_ratio.pdf")
#plot(h2_DRB,type="l",ylim=c(c.min,c.max),xaxt='n',xlab="",ylab="CPM Normalized acH2AZ ChIP-Seq Tags",col='#619CFF',lwd=3)
lines(h2_DRB,col="#619CFF",lwd=3)

Axis(side=1, labels=c("-2 KB","TSS","2 KB"),at=c(1,97,200))
polygon( c(1:200,rev(c(1:200)) ),c(h2_DRB_conf[1,],rev(h2_DRB_conf[2,])), col = alpha('#619CFF',.3), border = NA)
lines(h2_ACTD,col="#F8766D",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(h2_ACTD_conf[1,],rev(h2_ACTD_conf[2,])), col = alpha('#F8766D',.3), border = NA) 
legend("topright", legend=c("DRB/DMSO","ACTD/DMSO"), fill=c('#619CFF','#F8766D'), bty = "n",cex = 1.3)
                   abline(v=97,lty=2)

dev.off()
                   
      ##########################
#Read in files
library(graphics)
library(RColorBrewer)

h2az = read.table(pipe("grep -v '#' h2azOnly_20bp_2kb_QNORM.rmat|grep -v  'genes'"),sep="\t")
ach2az = read.table(pipe("grep -v '#' ach2azOnly_20bp_2kb_CPM.rmat|grep -v  'genes'"),sep="\t")

# 1-200 = DRB
# 201-400 = ACTD
# 401-600 = DMSO

svg("scatterplots.svg")
par(mfrow=c(2,2))
smoothScatter(asinh(rowSums(h2az[,1:200])),asinh(rowSums(h2az[,401:600]) ),xlab= "DRB",ylab="DMSO",main = "H2AZ",xlim=c(6,13),
            ylim=c(6,13) )   
abline(a=0,b=1)
                   
smoothScatter(asinh(rowSums(ach2az[,1:200])),asinh(rowSums(ach2az[,401:600]) ),xlab= "DRB",ylab="DMSO",main = "acH2AZ",xlim=c(0,7),
            ylim=c(0,7) )   
abline(a=0,b=1)
                   
smoothScatter(asinh(rowSums(h2az[,201:400])),asinh(rowSums(h2az[,401:600]) ),xlab= "ACTD",ylab="DMSO",main = "H2AZ",xlim=c(6,13),
            ylim=c(6,13) )   
abline(a=0,b=1)
                   
smoothScatter(asinh(rowSums(ach2az[,201:400])),asinh(rowSums(ach2az[,401:600]) ),xlab= "ACTD",ylab="DMSO",main = "acH2AZ",xlim=c(0,7),
            ylim=c(0,7) )   
abline(a=0,b=1)
dev.off()
                   
######################
#Read in files
library(graphics)
library(RColorBrewer)
                   
h2az = read.table(pipe("grep -v '#' h2azOnly_20bp_2kb_QNORM.rmat|grep -v 'genes'"),sep="\t")

ach2az = read.table(pipe("grep -v '#' ach2azOnly_20bp_2kb_CPM.rmat|grep -v 'genes'"),sep="\t")

brewer.pal(11, "RdYlBu")


#pdf("scatterplots_hyperSaturatingColor.pdf")
#svg("scatterplots_hyperSaturatingColor.svg")
#buylrd <- c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", "#FFFFBF", "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026",
#            "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026",
#           "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026",
#           "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026") 
#pdf("scatterplots_mediumSaturatingColor.pdf")
#svg("scatterplots_mediumSaturatingColor.svg")
png("scatterplots_mediumSaturatingColor.png",res = 300,width = 4, height = 4, units = 'in')
buylrd <- c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", "#FFFFBF", "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026",
            "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026",
           "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026")
#pdf("scatterplots_NOSaturatingColor.pdf")
#svg("scatterplots_NOSaturatingColor.svg")
#buylrd <- c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", "#FFFFBF", "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026")
            
par(mfrow=c(2,2))

# DRB DMSO H2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(h2az[,1:200])),asinh(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
par(new=NULL)
#
# DRB DMSO acH2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(ach2az[,1:200])),asinh(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
par(new=NULL)
#
# ACTD DMSO H2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(h2az[,201:400])),asinh(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
par(new=NULL)
#
# ACTD DMSO acH2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(ach2az[,201:400])),asinh(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
par(new=NULL)
#
dev.off()
