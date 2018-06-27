h2az = read.table(pipe("grep -v -P '#|genes' h2azOnly_20bp_2kb_QNORM.rmat"),sep="\t")

ach2az = read.table(pipe("grep -v -P '#|genes' ach2azOnly_20bp_2kb_CPM.rmat"),sep="\t")
#

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

c.min=min(confi_wt1,confi_wt2,confi_dm1,confi_dm2,confi_tp1,confi_tp2)
c.max=max(confi_wt1,confi_wt2,confi_dm1,confi_dm2,confi_tp1,confi_tp2)
c.name=paste("Cluster",n,"Trajectories","\n(",sum(common),"genes )")

plot(apply(wt1,2,mean),main=paste(c.name),type="l",ylim=c(c.min,c.max),xaxt='n',xlab="",ylab="")
polygon( c(1,2,3,4,rev(c(1,2,3,4)) ),c(confi_wt1[1,],rev(confi_wt1[2,])), col = alpha('salmon',.2), border = NA)
lines(apply(wt1,2,mean),col="salmon",lwd=1.6)
polygon( c(1,2,3,4,rev(c(1,2,3,4)) ),c(confi_wt2[1,],rev(confi_wt2[2,])), col = alpha('darkred',.2), border = NA)
lines(apply(wt2,2,mean),col="darkred",lwd=1.6)
