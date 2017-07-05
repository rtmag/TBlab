more fisher_neb.txt|perl -pe 's/^/chr/g'|perl -pe 's/(chr([1-9]|1[0-9]|2[0-2]))\t/$1HOLAMUNDO\t/g'| \
perl -pe "s/chr23\t/chrXHOLAMUNDO\t/g"|perl -pe 's/chr24\t/chrYHOLAMUNDO\t/g'|grep "HOLAMUNDO"| \
perl -pe 's/HOLAMUNDO//g' > fisher_neb_all.txt

#R
x=read.table("fisher_neb_all.txt",sep="\t",header=F,stringsAsFactors=F)

diff=x[(x[,6]<0.05 & x[,7]<(-25)),]
write.table(diff,"fisher_neb_diff.txt",quote=F,row.names=F,col.names=F,sep="\t")

undiff=x[ x[,7]>(-25) & rowMeans(cbind(x[,8],x[,9]))>.650 & x[,6]>0.05,]
write.table(undiff,"fisher_neb_undiff.txt",quote=F,row.names=F,col.names=F,sep="\t")


#1)CpG are in clusters 
annotatePeaks.pl fisher_neb_undiff.txt hg38 -annStats fisher_neb_undiff.stats > fisher_neb_undiff.anno #0.007735281
more fisher_neb_undiff.anno |cut -f9|grep CpG|wc -l # 1116
more fisher_neb_undiff.anno |cut -f9|wc -l # 144274

annotatePeaks.pl fisher_neb_diff.txt hg38 > fisher_neb_diff.anno #0.009707245
more fisher_neb_diff.anno |cut -f9|grep CpG|wc -l # 13955
more fisher_neb_diff.anno |cut -f9|wc -l # 1437586
# R
dmc=read.table("fisher_neb_diff.txt",sep="\t",stringsAsFactors=F)
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
  plot(position,log10(difference),xlab="Chromosome position",ylab="Log10 DMC interdistance",main=chr[i],col=adjustcolor("black",alpha=.006))
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

awk -F"\t" '{print $1"\t"$2"\t"$2+1}' fisher_neb_diff.txt > fisher_neb_diff.bed
awk -F"\t" '{print $1"\t"$2"\t"$2+1}' fisher_neb_undiff.txt > fisher_neb_undiff.bed

computeMatrix reference-point \
-S atac.bw P53_Venkata.bw P53_24h_doxo_s1.bw P53_48h_doxo_s1.bw H3K27ac.bw H3K4me1.bw H3K4me3.bw H3K9me3.bw H3K36me3.bw \
-R fisher_neb_diff.bed \
--missingDataAsZero --sortRegions descend -bs 1 -a 1000 -b 1000 -p max -out diff_all_descend.mat


computeMatrix reference-point -S atac.bw P53_Venkata.bw P53_24h_doxo_s1.bw P53_48h_doxo_s1.bw H3K27ac.bw H3K4me1.bw H3K4me3.bw H3K9me3.bw H3K36me3.bw -R fisher_neb_undiff.bed --missingDataAsZero --sortRegions descend -bs 1 -a 1000 -b 1000 -p max -out undiff_all_descend.mat

##
samtools view -h H3K27ac_rmdup_sort.bam > H3K27ac_rmdup_sort.sam
samtools view -h H3K36me3_rmdup_sort.bam > H3K36me3_rmdup_sort.sam
samtools view -h H3K4me1_rmdup_sort.bam > H3K4me1_rmdup_sort.sam
samtools view -h H3K4me3_rmdup_sort.bam > H3K4me3_rmdup_sort.sam
samtools view -h H3K9me3_rmdup_sort.bam > H3K9me3_rmdup_sort.sam
samtools view -h H3K27me3_rmdup_sort.bam > H3K27me3_rmdup_sort.sam

H3K27me3_rmdup_sort.bam

makeTagDirectory H3K27ac_ChIP-Seq/ H3K27ac_rmdup_sort.sam -format sam
makeTagDirectory H3K36me3_ChIP-Seq/ H3K36me3_rmdup_sort.sam -format sam
makeTagDirectory H3K4me1_ChIP-Seq/ H3K4me1_rmdup_sort.sam -format sam
makeTagDirectory H3K4me3_ChIP-Seq/ H3K4me3_rmdup_sort.sam -format sam &
makeTagDirectory H3K9me3_ChIP-Seq/ H3K9me3_rmdup_sort.sam -format sam &
makeTagDirectory H3K27me3_ChIP-Seq/ H3K27me3_rmdup_sort.sam -format sam

annotatePeaks.pl ~/heatmaps/fisher_neb_diff.bed hg38 -size -2000,2000 -hist 1 -ghist \
-d H3K27ac_ChIP-Seq/ H3K27me3_ChIP-Seq/ H3K36me3_ChIP-Seq/ H3K4me1_ChIP-Seq/ H3K4me3_ChIP-Seq/ H3K9me3_ChIP-Seq/ > fisher_neb_diff.mat

#9)Intersection between Hypo methylated cpgs after P53-KO vs Hypomethylated after 5az treatment
#10)Steph's HCT116 atac-seq great analysis (Only promoters and complete set).
macs2 callpeak -t atac_steph1_Aligned.sortedByCoord.out.bam -f BAMPE -n hct116_atac_ -g hs --broad --keep-dup all -q 

