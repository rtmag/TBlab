#download annotation
system("wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_36/gencode.v36.annotation.gtf.gz")
system("zcat gencode.v36.annotation.gtf.gz |perl -pe  's/^chr|%$//g' > gencode.v36.annotation_chrRemoved.gtf")

`awk '{if ($3 == "gene") print $0;}'  gencode.v36.annotation_chrRemoved.gtf| grep -v "^#" |cut -f1,4,5,7,9|perl -pe 's/gene_id.+gene\_name \"//g'|perl -pe 's/\"\;.+//g'|\
awk -F"\t" '{if($4=="+"){print $1"\t"$2-1"\t"$2"\t"$5"\t.\t"$4};if($4=="-"){print $1"\t"$3"\t"$3+1"\t"$5"\t.\t"$4} }' > TSS_gencode.v36.annotation_chrRemoved.bed`


# RPKM calculation
library(edgeR)
library(Rsubread)
options(scipen=999)

data<-featureCounts(c(
"hl60_nuclei_S-phase_1h_clicked.sorted.bam",
"hl60_nuclei_S-phase_1h.sorted.bam"
),
annot.ext="gencode.v36.annotation_chrRemoved.gtf",
isGTFAnnotationFile=TRUE,
minMQS=4,
strandSpecific=0,
isPairedEnd=TRUE,
autosort=TRUE,
nthreads=40,
GTF.attrType="gene_name"
)


x <- DGEList(counts=data$counts, genes=data$annotation[,c("GeneID","Length")])
x_rpkm <- rpkm(x,x$genes$Length)

colnames(x_rpkm)=c("hl60_nuclei_S-phase_1h_clicked","hl60_nuclei_S-phase_1h")

saveRDS(x_rpkm,"hl60_nuclei_rpkm.rds")
write.table(x_rpkm, "hl60_nuclei_rpkm.txt",sep="\t",col.names=T,row.names=T,quote=F)
write.csv(x_rpkm, "hl60_nuclei_rpkm.csv")

##########
# REDO just RPKM

# RPKM calculation
library(edgeR)
library(Rsubread)
options(scipen=999)


x=read.table('TSS_gencode.v36.annotation_chrRemoved.bed',sep="\t",stringsAsFactors=F)

x[x[,6]=="+",2] <- x[x[,6]=="+",2]-2000
x[x[,6]=="-",3] <- x[x[,6]=="-",3]+2000
x[x[,2]<1,2] = 1

ann = data.frame(GeneID=x[,4],Chr=x[,1],Start=x[,2],End=x[,3],Strand='+')

fc_SE <- featureCounts(c("hl60_nuclei_S-phase_1h_clicked.sorted.bam","hl60_nuclei_S-phase_1h.sorted.bam"),
                       annot.ext=ann,isPairedEnd=FALSE,nthreads=40)


x_rpkm <- DGEList(counts=fc_SE$counts, genes=fc_SE$annotation[,c("GeneID","Length")])
x_rpkm <- rpkm(x_rpkm,x_rpkm$genes$Length)

rpkm<-readRDS("hl60_nuclei_rpkm.rds")

mbind<-function(...){
 Reduce( function(x,y){cbind(x,y[match(row.names(x),row.names(y)),])}, list(...) )
}

combined_data<- mbind(rpkm,x_rpkm)

colnames(combined_data)<- c("GENES_hl60_nuclei_S-phase_1h_clicked","GENES_hl60_nuclei_S-phase_1h","2KBups_sum_hl60_nuclei_S-phase_1h_clicked","2KBups_sum_hl60_nuclei_S-phase_1h")

saveRDS(combined_data,"HL60_nuclei_RPKM.rds")
write.csv(combined_data,"HL60_nuclei_RPKM.csv")



###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
###########################################################################################################################################################################
# below is the wrong analysis done due to a missunderstanding, as it is an interesting type of analysis.

# CPM normalization and transfomation into bigwig:
bamCoverage -p max -bs 1 --normalizeUsing CPM -b hl60_nuclei_S-phase_1h.sorted.bam -o hl60_nuclei_S-phase_1h.sorted.bw
bamCoverage -p max -bs 1 --normalizeUsing CPM -b hl60_nuclei_S-phase_1h_clicked.sorted.bam -o hl60_nuclei_S-phase_1h_clicked.sorted.bw
##
system("samtools index hl60_nuclei_S-phase_1h.sorted.bam")
system("samtools index hl60_nuclei_S-phase_1h_clicked.sorted.bam")

system("bamCoverage -p max -bs 1 --normalizeUsing CPM -b hl60_nuclei_S-phase_1h_clicked.sorted.bam -o hl60_nuclei_S-phase_1h_clicked.sorted.bw")
system("bamCoverage -p max -bs 1 --normalizeUsing CPM -b hl60_nuclei_S-phase_1h.sorted.bam -o hl60_nuclei_S-phase_1h.sorted.bw")
# counting signal at TSS -2KB; MEAN function to count signal
system("
computeMatrix reference-point \
-S \
hl60_nuclei_S-phase_1h_clicked.sorted.bw \
hl60_nuclei_S-phase_1h.sorted.bw \
-R TSS_gencode.v36.annotation_chrRemoved.bed --referencePoint center \
--sortRegions keep -bs 2000 -a 0 -b 2000 -p 40 -out hl60_nuclei.mat --outFileNameMatrix hl60_nuclei.rmat --outFileSortedRegions hl60_nuclei_regions.bed
")
# counting signal at TSS -2KB; SUM function to count signal
system("
computeMatrix reference-point \
-S \
hl60_nuclei_S-phase_1h_clicked.sorted.bw \
hl60_nuclei_S-phase_1h.sorted.bw  --averageTypeBins sum \
-R TSS_gencode.v36.annotation_chrRemoved.bed --referencePoint center \
--sortRegions keep -bs 2000 -a 0 -b 2000 -p 40 -out hl60_nuclei_sum.mat --outFileNameMatrix hl60_nuclei_sum.rmat --outFileSortedRegions hl60_nuclei_sum_regions.bed
")



#integrating everything
# mean
bed<-read.table("hl60_nuclei_regions.bed",sep="\t")
tss <- read.table(pipe("grep -v '#' hl60_nuclei.rmat|grep -v 'hl60_nuclei_S'"),sep='\t')
rownames(tss)<-as.character(bed[,4])
rpkm<-readRDS("hl60_nuclei_rpkm.rds")

rpkm <- rpkm[rownames(rpkm) %in% rownames(tss),]
tss <- tss[rownames(tss) %in% rownames(rpkm),]
table(rownames(rpkm) == rownames(tss)) #all match

combined_data <- cbind(rpkm,tss)
colnames(combined_data)<- c("RPKM_hl60_nuclei_S-phase_1h_clicked","RPKM_hl60_nuclei_S-phase_1h","CPM_mean_hl60_nuclei_S-phase_1h_clicked","CPM_mean_hl60_nuclei_S-phase_1h")

saveRDS(combined_data,"hl60_nuclei_RPKM_meanCPM.rds")
write.csv(combined_data,"hl60_nuclei_RPKM_meanCPM.csv")

# Sum
bed<-read.table("hl60_nuclei_sum_regions.bed",sep="\t")
tss <- read.table(pipe("grep -v '#' hl60_nuclei_sum.rmat|grep -v 'hl60_nuclei_S'"),sep='\t')
rownames(tss)<-as.character(bed[,4])
rpkm<-readRDS("hl60_nuclei_rpkm.rds")

rpkm <- rpkm[rownames(rpkm) %in% rownames(tss),]
tss <- tss[rownames(tss) %in% rownames(rpkm),]
table(rownames(rpkm) == rownames(tss)) #all match

combined_data <- cbind(rpkm,tss)
colnames(combined_data)<- c("RPKM_hl60_nuclei_S-phase_1h_clicked","RPKM_hl60_nuclei_S-phase_1h","CPM_sum_hl60_nuclei_S-phase_1h_clicked","CPM_sum_hl60_nuclei_S-phase_1h")

saveRDS(combined_data,"hl60_nuclei_RPKM_sumCPM.rds")
write.csv(combined_data,"hl60_nuclei_RPKM_sumCPM.csv")


