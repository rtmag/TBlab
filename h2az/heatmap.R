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
Axis(side=1, labels=c("-2 KB","TSS","2 KB"),at=c(1,100,200))
polygon( c(1:200,rev(c(1:200)) ),c(h2_DRB_conf[1,],rev(h2_DRB_conf[2,])), col = alpha('#619CFF',.3), border = NA)
lines(h2_ACTD,col="#F8766D",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(h2_ACTD_conf[1,],rev(h2_ACTD_conf[2,])), col = alpha('#F8766D',.3), border = NA)       
lines(h2_DMSO,col="#00BA38",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(h2_DMSO_conf[1,],rev(h2_DMSO_conf[2,])), col = alpha('#00BA38',.3), border = NA)
legend("topright", legend=c("DRB","ACTD","DMSO"), fill=c('#619CFF','#F8766D','#00BA38'), bty = "n",cex = 1.3)
dev.off()
                   
c.min=min(ac_DRB_conf,ac_ACTD_conf,ac_DMSO_conf)
c.max=max(ac_DRB_conf,ac_ACTD_conf,ac_DMSO_conf)
   
pdf("acH2AZ_profile_95confInterval.pdf")
plot(ac_DRB,type="l",ylim=c(c.min,c.max),xaxt='n',xlab="",ylab="CPM Normalized acH2AZ ChIP-Seq Tags",col='#619CFF',lwd=3)
Axis(side=1, labels=c("-2 KB","TSS","2 KB"),at=c(1,100,200))
polygon( c(1:200,rev(c(1:200)) ),c(ac_DRB_conf[1,],rev(ac_DRB_conf[2,])), col = alpha('#619CFF',.3), border = NA)
lines(ac_ACTD,col="#F8766D",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(ac_ACTD_conf[1,],rev(ac_ACTD_conf[2,])), col = alpha('#F8766D',.3), border = NA)       
lines(ac_DMSO,col="#00BA38",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(ac_DMSO_conf[1,],rev(ac_DMSO_conf[2,])), col = alpha('#00BA38',.3), border = NA)
legend("topright", legend=c("DRB","ACTD","DMSO"), fill=c('#619CFF','#F8766D','#00BA38'), bty = "n",cex = 1.3)
dev.off()
   

#########################################################################################################################
# Quantilez
library(gplots)
library(ggplot2)

h2_DRB=colMeans(h2az)[1:200]
h2_ACTD=colMeans(h2az)[201:400]
h2_DMSO=colMeans(h2az)[401:600]

ac_DRB=colMeans(ach2az)[1:200]
ac_ACTD=colMeans(ach2az)[201:400]
ac_DMSO=colMeans(ach2az)[401:600]

h2_DRB_conf=apply(h2az[,1:200],2,function(x) summary(x)[c(2,5)])
h2_ACTD_conf=apply(h2az[,201:400],2,function(x) summary(x)[c(2,5)])
h2_DMSO_conf=apply(h2az[,401:600],2,function(x) summary(x)[c(2,5)])

ac_DRB_conf=apply(ach2az[,1:200],2,function(x) summary(x)[c(2,5)])
ac_ACTD_conf=apply(ach2az[,201:400],2,function(x) summary(x)[c(2,5)])
ac_DMSO_conf=apply(ach2az[,401:600],2,function(x) summary(x)[c(2,5)])

#
library(graphics)
library(Cairo)

c.min=min(h2_DRB_conf,h2_ACTD_conf,h2_DMSO_conf)
c.max=max(h2_DRB_conf,h2_ACTD_conf,h2_DMSO_conf)

pdf("H2AZ_profile_1st_3rd_quantiles.pdf")
plot(h2_DRB,type="l",ylim=c(c.min,c.max),xaxt='n',xlab="",ylab="Quantile Normalized H2AZ ChIP-Seq Tags",col='#619CFF',lwd=3)
Axis(side=1, labels=c("-2 KB","TSS","2 KB"),at=c(1,100,200))
polygon( c(1:200,rev(c(1:200)) ),c(h2_DRB_conf[1,],rev(h2_DRB_conf[2,])), col = alpha('#619CFF',.3), border = NA)
lines(h2_ACTD,col="#F8766D",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(h2_ACTD_conf[1,],rev(h2_ACTD_conf[2,])), col = alpha('#F8766D',.3), border = NA)       
lines(h2_DMSO,col="#00BA38",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(h2_DMSO_conf[1,],rev(h2_DMSO_conf[2,])), col = alpha('#00BA38',.3), border = NA)
legend("topright", legend=c("DRB","ACTD","DMSO"), fill=c('#619CFF','#F8766D','#00BA38'), bty = "n",cex = 1.3)
dev.off()
                   
c.min=min(ac_DRB_conf,ac_ACTD_conf,ac_DMSO_conf)
c.max=max(ac_DRB_conf,ac_ACTD_conf,ac_DMSO_conf)
   
pdf("acH2AZ_profile_1st_3rd_quantiles.pdf")
plot(ac_DRB,type="l",ylim=c(c.min,c.max),xaxt='n',xlab="",ylab="CPM Normalized acH2AZ ChIP-Seq Tags",col='#619CFF',lwd=3)
Axis(side=1, labels=c("-2 KB","TSS","2 KB"),at=c(1,100,200))
polygon( c(1:200,rev(c(1:200)) ),c(ac_DRB_conf[1,],rev(ac_DRB_conf[2,])), col = alpha('#619CFF',.3), border = NA)
lines(ac_ACTD,col="#F8766D",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(ac_ACTD_conf[1,],rev(ac_ACTD_conf[2,])), col = alpha('#F8766D',.3), border = NA)       
lines(ac_DMSO,col="#00BA38",lwd=3)
polygon( c(1:200,rev(c(1:200)) ),c(ac_DMSO_conf[1,],rev(ac_DMSO_conf[2,])), col = alpha('#00BA38',.3), border = NA)
legend("topright", legend=c("DRB","ACTD","DMSO"), fill=c('#619CFF','#F8766D','#00BA38'), bty = "n",cex = 1.3)
dev.off()
                   
                   
                   
                   
                   
                   
