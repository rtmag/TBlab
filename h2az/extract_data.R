                   
h2az = read.table(pipe("grep -v '#' h2azOnly_20bp_2kb_QNORM.rmat|grep -v 'genes'"),sep="\t")

ach2az = read.table(pipe("grep -v '#' ach2azOnly_20bp_2kb_CPM.rmat|grep -v 'genes'"),sep="\t")

#######################################################
h2az_DRB = h2az[,1:200]

h2az_ACTD = h2az[,201:400]

h2az_DMSO = h2az[,401:600]

ach2az_DRB = ach2az[,1:200]

ach2az_ACTD = ach2az[,201:400]

ach2az_DMSO = ach2az[,401:600]

saveRDS(h2az_DRB,"h2az_DRB.rds")
saveRDS(h2az_ACTD,"h2az_ACTD.rds")
saveRDS(h2az_DMSO,"h2az_DMSO.rds")

saveRDS(ach2az_DRB,"ach2az_DRB.rds")
saveRDS(ach2az_ACTD,"ach2az_ACTD.rds")
saveRDS(ach2az_DMSO,"ach2az_DMSO.rds")

write.csv(h2az_DRB,"h2az_DRB.csv")
write.csv(h2az_ACTD,"h2az_ACTD.csv")
write.csv(h2az_DMSO,"h2az_DMSO.csv")

write.csv(ach2az_DRB,"ach2az_DRB.csv")
write.csv(ach2az_ACTD,"ach2az_ACTD.csv")
write.csv(ach2az_DMSO,"ach2az_DMSO.csv")
