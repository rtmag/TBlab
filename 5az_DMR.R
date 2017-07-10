
read.table("fisher_neb_diff.mat", colClasses = c(rep("NULL", 1), rep("integer", 4000),rep("NULL",20006), header = TRUE)
           
x=read.table("fisher_neb_diff.mat", row.names=1, header = TRUE)
