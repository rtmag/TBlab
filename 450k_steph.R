

library(RnBeads)
rnb.set.norm=load.rnb.set("rnb.set.norm.RData.zip")

rnb.set.norm@pheno=data.frame(rnb.set.norm@pheno, 
                              Time=c("0","12","24","48","0","12","24","48","0","12","48","ctrl",
                                     "0","12","24","48","0","12","24","48","0","12","48","ctrl"),
                              reps=c("wt_0","wt_12","wt_24","wt_48","p53_0","p53_12","p53_24","p53_48",
                                    "dnmt1_0","dnmt1_12","dnmt1_48","ctrl",
                                    "wt_0","wt_12","wt_24","wt_48","p53_0","p53_12","p53_24","p53_48",
                                    "dnmt1_0","dnmt1_12","dnmt1_48","ctrl")
                             )

WT_VS_TP53_0h=remove.samples(rnb.set.norm,samples(rnb.set.norm)[c(2:4,6:12,14:16,18:24)] )
WT_VS_TP53_0h_dmr <- rnb.execute.computeDiffMeth(WT_VS_TP53_0h,pheno.cols=c("reps"))


WT_VS_TP53_48h=remove.samples(rnb.set.norm,samples(rnb.set.norm)[c(1:3,5:7,9:15,17:19,21:24)] )
WT_VS_TP53_48h_dmr <- rnb.execute.computeDiffMeth(WT_VS_TP53_48h,pheno.cols=c("reps"))


comparison <- get.comparisons(WT_VS_TP53_0h_dmr)[1]
WT_VS_TP53_0h_dmr_table <-get.table(WT_VS_TP53_0h_dmr, comparison, "sites", return.data.frame=TRUE)
comparison <- get.comparisons(WT_VS_TP53_48h_dmr)[1]
WT_VS_TP53_48h_dmr_table <-get.table(WT_VS_TP53_48h_dmr, comparison, "sites", return.data.frame=TRUE)
