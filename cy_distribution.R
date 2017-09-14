inter=read.table("~/Downloads/AML_001_run1_nanoSV-WGS-intersect.tsv",sep="\t",stringsAsFactors=F)

nano = inter[,5]

nano[nano=="E-Nov_Ins_bp"]="Novel Insertion"
nano[nano=="S-Nov_Ins_bp"]="Novel Insertion"
nano[nano=="Nov_Ins"]="Novel Insertion"

nano[nano=="Inter-Ins(1)"]="Translocation"
nano[nano=="InterTx"]="Translocation"
nano[nano=="Intra-Ins"]="Translocation"
nano[nano=="Intra-Ins(1)"]="Translocation"

nano[nano=="E-Nov_Ins"]="TRASH"
nano[nano=="Inter-Ins(2)"]="TRASH"
nano[nano=="Intra-Ins(2)"]="TRASH"
nano[nano=="S-Nov_Ins"]="TRASH"

nano[nano=="Del"]="Deletion"
nano[nano=="Inv"]="Inversion"
nano[nano=="TDupl"]="Duplication"
#
ngs = inter[,10]
ngs[ngs=="<DEL>"]="Deletion"
ngs[ngs=="<DUP>"]="Duplication"
ngs[ngs=="<INV>"]="Inversion"
ngs[ngs=="<TRA>"]="Translocation"
###########
colu=cbind(ngs,nano)

colu_noTrash=colu[!(colu[,2]=="TRASH"),]

nano_table=table(colu_noTrash[,2])
ngs_table=table(colu_noTrash[,1])

ngs_table=c(ngs_table[1:3],0,ngs_table[4])
names(ngs_table)=c("Deletion","Duplication","Inversion","Novel Insertion","Translocation")

par(mfrow=c(1,2))
barplot(ngs_table,border=NA,col="salmon",main="NGS",ylim=c(0,250))
barplot(nano_table,border=NA,col="darkturquoise",main="NANOPORE",ylim=c(0,250))
