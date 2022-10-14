#!/bin/Rscript
setwd("C:\\Users\\Administrator\\Desktop\\R画图")

library(ggplot2)
library(tidyverse)

combined_genes_of_interest <- read.table("combined_genes_Clara.txt",sep="\t",header=T)
colnames(combined_genes_of_interest)[4:5] <- c("cnv_bicseq2","snparray")
combined_genes_of_interest_long <- combined_genes_of_interest %>%
    pivot_longer(
        cols = c("cnv_bicseq2", "snparray"),
        names_to = "pipeline",
        values_to = "cnv"
    )

p <- ggplot(combined_genes_of_interest_long, aes(x=run_name, y=pipeline, fill = cnv)) +
    geom_tile() +
    facet_grid(rows=vars(gene), cols=vars(status), scale="free", space="free") +  
    scale_fill_gradient2(
        low = "darkblue", 
        mid = "white", 
        high = "darkred", 
        midpoint = 0
      ) +
  theme(axis.text.x= element_text(angle=90,size=16),
        axis.text.y = element_text(size=18,face="bold"), 
        axis.title.x = element_text(face = "bold",size = 17),
        axis.title.y = element_text(face = "bold",size = 17),
        strip.text.x = element_text(size = 18,face = "bold"),
        strip.text.y = element_text(size = 18,face = "bold"))


pdf("gene_level_Clara_CNV.pdf",height=18,width = 40)
p
dev.off()
