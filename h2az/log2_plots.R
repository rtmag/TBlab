#Read in files
library(graphics)
library(RColorBrewer)
                   
h2az = read.table(pipe("grep -v '#' h2azOnly_20bp_2kb_QNORM.rmat|grep -v 'genes'"),sep="\t")
ach2az = read.table(pipe("grep -v '#' ach2azOnly_20bp_2kb_CPM.rmat|grep -v 'genes'"),sep="\t")


pdf("scatterplots_log2.pdf")

buylrd <- c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", "#FFFFBF", "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026")

          
  
par(mfrow=c(2,2))

# DRB DMSO H2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(log2(rowSums(h2az[,1:200])),log2(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
abline(1,1,lty=2)
abline(-1,1,lty=2)
par(new=NULL)
#
# DRB DMSO acH2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(log2(rowSums(ach2az[,1:200])),log2(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
abline(1,1,lty=2)
abline(-1,1,lty=2)
par(new=NULL)
#
# ACTD DMSO H2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(log2(rowSums(h2az[,201:400])),log2(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
abline(1,1,lty=2)
abline(-1,1,lty=2)
par(new=NULL)
#
# ACTD DMSO acH2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(log2(rowSums(ach2az[,201:400])),log2(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
abline(1,1,lty=2)
abline(-1,1,lty=2)
par(new=NULL)
#
dev.off()
              
#
DRB_DMS_H2AZ = log2(rowSums(h2az[,1:200]))-log2(rowSums(h2az[,401:600]) )
ACT_DMS_H2AZ = log2(rowSums(h2az[,201:400]))-log2(rowSums(h2az[,401:600]) )

DRB_DMS_ACH2 = log2(rowSums(ach2az[,1:200]))-log2(rowSums(ach2az[,401:600]) )
ACT_DMS_ACH2 = log2(rowSums(ach2az[,201:400]))-log2(rowSums(ach2az[,401:600]) )
##############################
table(DRB_DMS_H2AZ==Inf|DRB_DMS_H2AZ==-Inf|DRB_DMS_H2AZ=='NaN'|DRB_DMS_H2AZ==NA)
table(ACT_DMS_H2AZ==Inf|ACT_DMS_H2AZ==-Inf|ACT_DMS_H2AZ=='NaN'|ACT_DMS_H2AZ==NA)
table(DRB_DMS_ACH2==Inf|DRB_DMS_ACH2==-Inf|DRB_DMS_ACH2=='NaN'|DRB_DMS_ACH2==NA)
table(ACT_DMS_ACH2==Inf|ACT_DMS_ACH2==-Inf|ACT_DMS_ACH2=='NaN'|ACT_DMS_ACH2==NA)
##############################
table( DRB_DMS_H2AZ > (1)   )      
table( DRB_DMS_H2AZ > (-1)   )          
              
table( ACT_DMS_H2AZ > (1)     )     
table( ACT_DMS_H2AZ < (-1)     )
              
table( DRB_DMS_ACH2 > (1)       )   
table( DRB_DMS_ACH2 < (-1)     )
              
table( ACT_DMS_ACH2 > (1)       )   
table( ACT_DMS_ACH2 < (-1)    )
##############################
              
table( DRB_DMS_H2AZ > (1) & ( log2(rowSums(h2az[,1:200]))>10| log2(rowSums(h2az[,401:600]) )>10  )      )
table( DRB_DMS_H2AZ < (-1) & ( log2(rowSums(h2az[,1:200]))>10| log2(rowSums(h2az[,401:600]) )>10  )     )          
              
table( ACT_DMS_H2AZ > (1)   & ( log2(rowSums(h2az[,201:400]))>10| log2(rowSums(h2az[,401:600]) )>10  )  )     
table( ACT_DMS_H2AZ < (-1)  & ( log2(rowSums(h2az[,201:400]))>10| log2(rowSums(h2az[,401:600]) )>10  )  )
              
table( DRB_DMS_ACH2 > (1)   & ( log2(rowSums(ach2az[,1:200]))>5| log2(rowSums(ach2az[,401:600]) )>5  )    )   
table( DRB_DMS_ACH2 < (-1)  & ( log2(rowSums(ach2az[,1:200]))>5| log2(rowSums(ach2az[,401:600]) )>5  )    )
              
table( ACT_DMS_ACH2 > (1)   & ( log2(rowSums(ach2az[,201:400]))>5| log2(rowSums(ach2az[,401:600]) )>5  )    )   
table( ACT_DMS_ACH2 < (-1)  & ( log2(rowSums(ach2az[,201:400]))>5| log2(rowSums(ach2az[,401:600]) )>5  )    )
