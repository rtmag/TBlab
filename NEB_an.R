
#1)CpG are in clusters 
more all_fish.txt|perl -pe 's/^/chr/g'|perl -pe 's/(chr([1-9]|1[0-9]|2[0-2]))\t/$1HOLAMUNDO\t/g'| \
perl -pe "s/chr23\t/chrXHOLAMUNDO\t/g"|perl -pe 's/chr24\t/chrYHOLAMUNDO\t/g'|grep "HOLAMUNDO"| \
perl -pe 's/HOLAMUNDO//g' > DMC_fisher.txt
# R
dmc=read.table("DMC_fisher.txt",sep="\t",stringsAsFactors=F)
options(scipen=999)
par(mfrow=c(3,2))
chr=c(paste("chr",1:22,sep=""),"chrX","chrY")
ploty=1
times=1
for(i in 1:length(chr)){

  if(ploty==1){
     png(paste("1_",times,"distance_DMC.png",sep=""))
      par(mfrow=c(3,2))
  }
  
  ix=(dmc[,1]==chr[i])
  difference=diff(dmc[ix,2])
  position=dmc[ix,2]
  position=position[-length(position)]
  plot(position,log10(difference),xlab="Chromosome position",ylab="Log10 DMC interdistance",main=chr[i],col=adjustcolor("black",alpha=.004))
  plot(density(log10(difference)),main=chr[i])
  ploty=ploty+1
  
  if(ploty==4){
     dev.off()
     ploty=1
     times=times+1
  }
  
}

#2)are they in CpG islands?
#3)Are they demethylated in groups or individual CpGs

#4)Annotation for non-differentially methlated

#5)are the differentially methylated more enriched in cpg islands compared to the non-differentially methylated
#6)Methylation profiles on ATAC-seq 
#7)Methylation profiles on NICE-Seq peaks (2,500 cells) 
#8)Perform histone mark heatmap profiles
#9)Intersection between Hypo methylated cpgs after P53-KO vs Hypomethylated after 5az treatment
#10)Steph's HCT116 atac-seq great analysis (Only promoters and complete set).

