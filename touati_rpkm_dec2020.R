system("wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_36/gencode.v36.annotation.gtf.gz")

# RPKM calculation
library(edgeR)
library(Rsubread)
options(scipen=999)

data<-featureCounts(c(
"hl60_nuclei_S-phase_1h_clicked.sorted.bam",
"hl60_nuclei_S-phase_1h.sorted.bam",
),
annot.ext="gencode.v36.annotation.gtf.gz",
isGTFAnnotationFile=TRUE,
minMQS=4,
strandSpecific=0,
isPairedEnd=TRUE,
autosort=TRUE,
nthreads=40,
GTF.attrType="gene_name"
)


data<-featureCounts(c(
"hl60_nuclei_S-phase_1h.sorted.bam",
),
annot.ext="gencode.v36.annotation.gtf.gz",
isGTFAnnotationFile=TRUE,
minMQS=4,
strandSpecific=0,
isPairedEnd=TRUE,
autosort=TRUE,
nthreads=40,
GTF.attrType="gene_name"
)

data<-featureCounts(c(
"hl60_nuclei_S-phase_1h.sorted.bam",
),
annot.ext="gencode.v36.annotation.gtf.gz",
isGTFAnnotationFile=TRUE,
minMQS=4,
strandSpecific=1,
isPairedEnd=TRUE,
autosort=TRUE,
nthreads=40,
GTF.attrType="gene_name"
)

data<-featureCounts(c(
"hl60_nuclei_S-phase_1h.sorted.bam",
),
annot.ext="gencode.v36.annotation.gtf.gz",
isGTFAnnotationFile=TRUE,
minMQS=4,
strandSpecific=2,
isPairedEnd=TRUE,
autosort=TRUE,
nthreads=40,
GTF.attrType="gene_name"
)


awk '{if ($$3 != "gene") print $0;}' file.gtf \
| grep -v "^#" \
| gtfToGenePred /dev/stdin /dev/stdout \
| genePredToBed stdin genes.bed

