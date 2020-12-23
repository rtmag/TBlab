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

# CPM normalization and transfomation into bigwig:
bamCoverage -p max -bs 1 --normalizeUsing CPM -b hl60_nuclei_S-phase_1h.sorted.bam -o hl60_nuclei_S-phase_1h.sorted.bw
bamCoverage -p max -bs 1 --normalizeUsing CPM -b hl60_nuclei_S-phase_1h_clicked.sorted.bam -o hl60_nuclei_S-phase_1h_clicked.sorted.bw
##
system("samtools index hl60_nuclei_S-phase_1h.sorted.bam")
system("samtools index hl60_nuclei_S-phase_1h_clicked.sorted.bam")

system("bamCoverage -p max -bs 1 --normalizeUsing CPM -b hl60_nuclei_S-phase_1h_clicked.sorted.bam -o hl60_nuclei_S-phase_1h_clicked.sorted.bw")
system("bamCoverage -p max -bs 1 --normalizeUsing CPM -b hl60_nuclei_S-phase_1h.sorted.bam -o hl60_nuclei_S-phase_1h.sorted.bw")


