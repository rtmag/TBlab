    
######################
#Read in files
library(graphics)
library(RColorBrewer)
                   
h2az = read.table(pipe("grep -v '#' h2azOnly_20bp_2kb_QNORM.rmat|grep -v 'genes'"),sep="\t")

ach2az = read.table(pipe("grep -v '#' ach2azOnly_20bp_2kb_CPM.rmat|grep -v 'genes'"),sep="\t")

brewer.pal(11, "RdYlBu")


png("scatterplots_mediumSaturatingColor_linearRegression.png",res = 300,width = 10, height = 8, units = 'in')
buylrd <- c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", "#FFFFBF", "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026",
            "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026",
           "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026")

par(mfrow=c(2,2))

# DRB DMSO H2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(h2az[,1:200])),asinh(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(h2az[,1:200])), dmso = asinh(rowSums(h2az[,401:600]) ) )
abline( lm(dmso ~ x,data=dta) ,col="white")
par(new=NULL)
#
# DRB DMSO acH2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(ach2az[,1:200])),asinh(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(ach2az[,1:200])), dmso = asinh(rowSums(ach2az[,401:600]) ) )
abline( lm(dmso ~ x,data=dta) ,col="white")
par(new=NULL)
#
# ACTD DMSO H2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(h2az[,201:400])),asinh(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(h2az[,201:400])), dmso = asinh(rowSums(h2az[,401:600]) ) )
abline( lm(dmso ~ x,data=dta) ,col="white")
par(new=NULL)
#
# ACTD DMSO acH2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(ach2az[,201:400])),asinh(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(ach2az[,201:400])), dmso = asinh(rowSums(ach2az[,401:600]) ) )
abline( lm(dmso ~ x,data=dta) ,col="white")
par(new=NULL)
#
dev.off()

###########################
#

png("scatterplots_mediumSaturatingColor_tetraPolyRegre.png",res = 300,width = 10, height = 8, units = 'in')
buylrd <- c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", "#FFFFBF", "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026",
            "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026",
           "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026")

par(mfrow=c(2,2))

# DRB DMSO H2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(h2az[,1:200])),asinh(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(h2az[,1:200])), dmso = asinh(rowSums(h2az[,401:600]) ) )
model = lm(dmso ~ poly(x,4),data=dta)
points(sort(dta$x), fitted(model)[order(dta$x)] ,col="white", type="l")
par(new=NULL)
#
# DRB DMSO acH2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(ach2az[,1:200])),asinh(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(ach2az[,1:200])), dmso = asinh(rowSums(ach2az[,401:600]) ) )
model = lm(dmso ~ poly(x,4),data=dta)
points(sort(dta$x), fitted(model)[order(dta$x)] ,col="white", type="l")
par(new=NULL)
#
# ACTD DMSO H2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(h2az[,201:400])),asinh(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(h2az[,201:400])), dmso = asinh(rowSums(h2az[,401:600]) ) )
model = lm(dmso ~ poly(x,4),data=dta)
points(sort(dta$x), fitted(model)[order(dta$x)] ,col="white", type="l")
par(new=NULL)
#
# ACTD DMSO acH2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(ach2az[,201:400])),asinh(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(ach2az[,201:400])), dmso = asinh(rowSums(ach2az[,401:600]) ) )
model = lm(dmso ~ poly(x,4),data=dta)
points(sort(dta$x), fitted(model)[order(dta$x)] ,col="white", type="l")
par(new=NULL)
#
dev.off()
###################

png("scatterplots_mediumSaturatingColor_cuadraticPolyRegre.png",res = 300,width = 10, height = 8, units = 'in')
buylrd <- c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", "#FFFFBF", "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026",
            "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026",
           "#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026", "#A50026","#A50026", "#A50026", "#A50026")

par(mfrow=c(2,2))

# DRB DMSO H2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(h2az[,1:200])),asinh(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(h2az[,1:200])), dmso = asinh(rowSums(h2az[,401:600]) ) )
model = lm(dmso ~ poly(x,2),data=dta)
points(sort(dta$x), fitted(model)[order(dta$x)] ,col="white", type="l")
par(new=NULL)
#
# DRB DMSO acH2AZ
plot(1, type="n",xlab= "DRB",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(ach2az[,1:200])),asinh(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(ach2az[,1:200])), dmso = asinh(rowSums(ach2az[,401:600]) ) )
model = lm(dmso ~ poly(x,2),data=dta)
points(sort(dta$x), fitted(model)[order(dta$x)] ,col="white", type="l")
par(new=NULL)
#
# ACTD DMSO H2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "H2AZ",xlim=c(6,13), ylim=c(6,13))
rect(xleft=5, ybottom=5, xright=14, ytop=14,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(h2az[,201:400])),asinh(rowSums(h2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(6,13), ylim=c(6,13))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(h2az[,201:400])), dmso = asinh(rowSums(h2az[,401:600]) ) )
model = lm(dmso ~ poly(x,2),data=dta)
points(sort(dta$x), fitted(model)[order(dta$x)] ,col="white", type="l")
par(new=NULL)
#
# ACTD DMSO acH2AZ
plot(1, type="n",xlab= "ACTD",ylab="DMSO",main = "acH2AZ",xlim=c(0,7), ylim=c(0,7))
rect(xleft=-1, ybottom=-1, xright=8, ytop=8,col="#313695",border=NA)
par(new=T)
smoothScatter(asinh(rowSums(ach2az[,201:400])),asinh(rowSums(ach2az[,401:600]) ), nbin=1000, colramp = colorRampPalette(c(buylrd)), 
              nrpoints=Inf,pch="", cex=.7, transformation = function(x) x^.6, col="black",axes=F, ann=F,xlim=c(0,7), ylim=c(0,7))
abline(a=0,b=1)
dta = data.frame( x = asinh(rowSums(ach2az[,201:400])), dmso = asinh(rowSums(ach2az[,401:600]) ) )
model = lm(dmso ~ poly(x,2),data=dta)
points(sort(dta$x), fitted(model)[order(dta$x)] ,col="white", type="l")
par(new=NULL)
#
dev.off()
###########################################################
