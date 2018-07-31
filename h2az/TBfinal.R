    
######################
#Read in files
library(graphics)
library(RColorBrewer)
                   
h2az = read.table(pipe("grep -v '#' h2azOnly_20bp_2kb_QNORM.rmat|grep -v 'genes'"),sep="\t")

ach2az = read.table(pipe("grep -v '#' ach2azOnly_20bp_2kb_CPM.rmat|grep -v 'genes'"),sep="\t")

####
pdf("colorGradient.pdf",width = 4, height = 4)
par(mfrow=c(1,3))
legend_image <- as.raster(matrix(cbind(rev(buylrd)), ncol=1))
plot(c(0,2),c(0,1),type = 'n', axes = F,xlab = '', ylab = '', main = '')
rasterImage(legend_image, 0, 0, 1,1)

legend_image <- as.raster(matrix(cbind(rev(c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", "#FFFFBF", "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026",
            "#A50026", "#A50026", "#A50026", "#A50026","#A50026"))), ncol=1))
plot(c(0,2),c(0,1),type = 'n', axes = F,xlab = '', ylab = '', main = '')
rasterImage(legend_image, 0, 0, 1,1)

legend_image <- as.raster(matrix(cbind(rev(c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", "#FFFFBF", "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026"
            ))), ncol=1))
plot(c(0,2),c(0,1),type = 'n', axes = F,xlab = '', ylab = '', main = '')
rasterImage(legend_image, 0, 0, 1,1)
dev.off()
#########
#CorTest
pdf("cortest.pdf")
par(mfrow=c(2,2))
plot(1,col='white',xlab= "DRB",ylab="DMSO",xaxt='n',yaxt='n',main="H2AZ")
tx = cor.test(asinh(rowSums(h2az[,1:200])),asinh(rowSums(h2az[,401:600]) ),method="pearson")$estimate
legend('center',paste("Pearson correlation",round(tx,digits=3)),bty = "n",cex=1)
plot(1,col='white',xlab= "DRB",ylab="DMSO",xaxt='n',yaxt='n',main="AcH2AZ")
tx = cor.test(asinh(rowSums(ach2az[,1:200])),asinh(rowSums(ach2az[,401:600]) ),method="pearson")$estimate
legend('center',paste("Pearson correlation",round(tx,digits=3)),bty = "n",cex=1)
plot(1,col='white',xlab= "ACTD",ylab="DMSO",xaxt='n',yaxt='n',main="H2AZ")
tx = cor.test(asinh(rowSums(h2az[,201:400])),asinh(rowSums(h2az[,401:600]) ),method="pearson")$estimate
legend('center',paste("Pearson correlation",round(tx,digits=3)),bty = "n",cex=1)
plot(1,col='white',xlab= "ACTD",ylab="DMSO",xaxt='n',yaxt='n',main="AcH2AZ")
tx = cor.test(asinh(rowSums(ach2az[,201:400])),asinh(rowSums(ach2az[,401:600]) ),method="pearson")$estimate
legend('center',paste("Pearson correlation",round(tx,digits=3)),bty = "n",cex=1)
dev.off()

smoothScatter(asinh(rowSums(h2az[,201:400])),asinh(rowSums(h2az[,401:600]) ))
smoothScatter(asinh(rowSums(ach2az[,201:400])),asinh(rowSums(ach2az[,401:600]) ))
#######################
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

              
              
              
h2az = read.table(pipe("grep -v '#' h2azOnly_20bp_2kb_QNORM.rmat|grep -v 'genes'"),sep="\t")
ach2az = read.table(pipe("grep -v '#' ach2azOnly_20bp_2kb_CPM.rmat|grep -v 'genes'"),sep="\t")

h2az_DRB = (rowSums(h2az[,1:200]))
h2az_ACTD = (rowSums(h2az[,201:400]))
h2az_DMSO = (rowSums(h2az[,401:600]))

ach2az_DRB = (rowSums(ach2az[,1:200]))
ach2az_ACTD = (rowSums(ach2az[,201:400]))
ach2az_DMSO = (rowSums(ach2az[,401:600]))
              
trh2 = summary(c(h2az_DRB,h2az_ACTD,h2az_DMSO))[5]
trac = summary(c(ach2az_DRB,ach2az_ACTD,ach2az_DMSO))[5]

h2_DRB_DMSO = (h2az_DRB/h2az_DMSO)
h2_DRB_DMSO = h2_DRB_DMSO[h2az_DRB>trh2 | h2az_DMSO>trh2]
table(h2_DRB_DMSO>2)
table(h2_DRB_DMSO<0.5)

h2_ACTD_DMSO = (h2az_ACTD/h2az_DMSO)
h2_ACTD_DMSO = h2_ACTD_DMSO[h2az_ACTD>trh2 | h2az_DMSO>trh2]
table(h2_ACTD_DMSO>2)
table(h2_ACTD_DMSO<0.5)
#
ach2_DRB_DMSO = (ach2az_DRB/ach2az_DMSO)
ach2_DRB_DMSO = ach2_DRB_DMSO[ach2az_DRB>trac | ach2az_DMSO>trac]
table(ach2_DRB_DMSO>2)
table(ach2_DRB_DMSO<0.5)

ach2_ACTD_DMSO = (ach2az_ACTD/ach2az_DMSO)
ach2_ACTD_DMSO = ach2_ACTD_DMSO[ach2az_ACTD>trac | ach2az_DMSO>trac]
table(ach2_ACTD_DMSO>2)
table(ach2_ACTD_DMSO<0.5)
              
####
