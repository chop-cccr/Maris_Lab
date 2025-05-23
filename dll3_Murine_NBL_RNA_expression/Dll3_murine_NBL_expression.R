########### ########### ########### ########### 
########### Notes ########### ########### 
#File Location: /mnt/isilon/maris_lab/target_nbl_ngs/Alvin/dll3_Murine_NB_Expression

#REQUEST:
#Thursday, April 3, 2025 at 5:10 PM
#Alvin, Tim, Minu—any chance in all of your spare time that you could give us a sense of DLL3 expression in the allografts and murine cell lines?
#Thanks very much.
#John

#Friday, April 4, 2025 at 12:21 PM
#Let us take a look at the RNA seq data and get back to you. Would be nice to see Dll3 in comparison with Gpc2, Alk, Dlk1, B7h3. Alvin, is this something Steven or Eric could do for us?
#Best wishes
#John M. Maris, MD

########### ########### ########### 
########### ########### ########### ########### 

library(ggplot2)




Dll3 = system("grep \"ENSMUSG00000003436\" /mnt/isilon/maris_lab/target_nbl_ngs/MDX_TH-MYCN_CAG_MYC_Genomics/RNAseq/quants/*genes.results",intern=T)
Gpc2 = system("grep \"ENSMUSG00000029510\" /mnt/isilon/maris_lab/target_nbl_ngs/MDX_TH-MYCN_CAG_MYC_Genomics/RNAseq/quants/*genes.results",intern=T)
Alk = system("grep \"ENSMUSG00000055471\" /mnt/isilon/maris_lab/target_nbl_ngs/MDX_TH-MYCN_CAG_MYC_Genomics/RNAseq/quants/*genes.results",intern=T)
Dlk1= system("grep \"ENSMUSG00000040856\" /mnt/isilon/maris_lab/target_nbl_ngs/MDX_TH-MYCN_CAG_MYC_Genomics/RNAseq/quants/*genes.results",intern=T)
B7h3_Cd276= system("grep \"ENSMUSG00000035914\" /mnt/isilon/maris_lab/target_nbl_ngs/MDX_TH-MYCN_CAG_MYC_Genomics/RNAseq/quants/*genes.results",intern=T)

Dll3_2 = system("grep \"ENSMUSG00000003436\" /mnt/isilon/maris_lab/target_nbl_ngs/Azenta_Project_30_1020175105/30-1020175105/quants/*genes.results",intern=T)
Gpc2_2 = system("grep \"ENSMUSG00000029510\" /mnt/isilon/maris_lab/target_nbl_ngs/Azenta_Project_30_1020175105/30-1020175105/quants/*genes.results",intern=T)
Alk_2 = system("grep \"ENSMUSG00000055471\" /mnt/isilon/maris_lab/target_nbl_ngs/Azenta_Project_30_1020175105/30-1020175105/quants/*genes.results",intern=T)
Dlk1_2= system("grep \"ENSMUSG00000040856\" /mnt/isilon/maris_lab/target_nbl_ngs/Azenta_Project_30_1020175105/30-1020175105/quants/*genes.results",intern=T)
B7h3_Cd276_2= system("grep \"ENSMUSG00000035914\" /mnt/isilon/maris_lab/target_nbl_ngs/Azenta_Project_30_1020175105/30-1020175105/quants/*genes.results",intern=T)


MDA_Gene_table = rbind(
  
  data.frame(Gene = "Dll3", read.delim(text=c(Dll3,Dll3_2), header = F)),
  data.frame(Gene = "Gpc2", read.delim(text=c(Gpc2,Gpc2_2), header = F)),
  data.frame(Gene = "Alk", read.delim(text=c(Alk,Alk_2), header = F)),
  data.frame(Gene = "Dlk1", read.delim(text=c(Dlk1,Dlk1_2), header = F)),
  data.frame(Gene = "B7h3/Cd276", read.delim(text=c(B7h3_Cd276,B7h3_Cd276_2), header = F))
)

colnames(MDA_Gene_table) = c("Gene","Name", "transcript_ids","length","effective_length","expected_count","TPM","FPKM")


MDA_Gene_table$Name = sapply(MDA_Gene_table$Name, function(X)  strsplit(gsub("/mnt/isilon/maris_lab/target_nbl_ngs/Azenta_Project_30_1020175105/30-1020175105/quants/|.genes.results|-DNA","",X), split=":")[[1]][1] )
MDA_Gene_table$Name = sapply(MDA_Gene_table$Name, function(X)  strsplit(gsub("/mnt/isilon/maris_lab/target_nbl_ngs/MDX_TH-MYCN_CAG_MYC_Genomics/RNAseq/quants/|.genes.results"," ",X), split=":")[[1]][1] )


ggplot(MDA_Gene_table, aes(x=Name,y=TPM, fill=Gene)) + geom_bar(stat = "identity", position = "dodge")+
  theme_classic()+
  theme(axis.text.x = element_text(size=12, angle = 90,hjust = 1,vjust=0.5))+   #, color=X_Axis_colors))+
  theme(axis.text.y = element_text(size=12))+    #,color = c(rep("darkgreen",Splice_count),rep("black",NoSplice_count-3),rep("darkred",3))))+
  theme(axis.title.x = element_blank())


ggplot(MDA_Gene_table, aes(x=Name,y=log10(TPM+1), fill=Gene)) + geom_bar(stat = "identity", position = "dodge")+
  theme_bw()+
  theme(axis.text.x = element_text(size=12, angle = 90,hjust = 1,vjust=0.5))+   #, color=X_Axis_colors))+
  theme(axis.text.y = element_text(size=12))+    #,color = c(rep("darkgreen",Splice_count),rep("black",NoSplice_count-3),rep("darkred",3))))+
  theme(axis.title.x = element_blank())+
  scale_y_continuous(breaks = c(0,1,2,3),labels = c(0,10,100,1000))+
  scale_y_continuous(breaks = c(0,1,2,3),labels = c(0,10,100,1000),limits = c(0,3))+
  ylab("TPM")
  
  
ggplot(subset(MDA_Gene_table, Gene=="Dll3"), aes(x=Name,y=TPM)) + geom_bar(stat = "identity", position = "dodge",fill="dodgerblue")+
  theme_classic()+
  theme(axis.text.x = element_text(size=12, angle = 90,hjust = 1,vjust=0.5))+   #, color=X_Axis_colors))+
  theme(axis.text.y = element_text(size=12))+    #,color = c(rep("darkgreen",Splice_count),rep("black",NoSplice_count-3),rep("darkred",3))))+
  theme(axis.title.x = element_blank())




Dll3_3 = system("grep \"ENSMUSG00000003436\" /mnt/isilon/maris_lab/target_nbl_ngs/MouseRNASeq_Weiss/quants/*genes.results",intern=T)
Gpc2_3 = system("grep \"ENSMUSG00000029510\" /mnt/isilon/maris_lab/target_nbl_ngs/MouseRNASeq_Weiss/quants/*genes.results",intern=T)
Alk_3 = system("grep \"ENSMUSG00000055471\" /mnt/isilon/maris_lab/target_nbl_ngs/MouseRNASeq_Weiss/quants/*genes.results",intern=T)
Dlk1_3= system("grep \"ENSMUSG00000040856\" /mnt/isilon/maris_lab/target_nbl_ngs/MouseRNASeq_Weiss/quants/*genes.results",intern=T)
B7h3_Cd276_3= system("grep \"ENSMUSG00000035914\" /mnt/isilon/maris_lab/target_nbl_ngs/MouseRNASeq_Weiss/quants/*genes.results",intern=T)


MDA_Gene_table_Weiss = rbind(
  
  data.frame(Gene = "Dll3", read.delim(text=Dll3_3, header = F)),
  data.frame(Gene = "Gpc2", read.delim(text=Gpc2_3, header = F)),
  data.frame(Gene = "Alk", read.delim(text=Alk_3, header = F)),
  data.frame(Gene = "Dlk1", read.delim(text=Dlk1_3, header = F)),
  data.frame(Gene = "B7h3/Cd276", read.delim(text=B7h3_Cd276_3, header = F))
)

colnames(MDA_Gene_table_Weiss) = c("Gene","Name", "transcript_ids","length","effective_length","expected_count","TPM","FPKM")


MDA_Gene_table_Weiss$Name = sapply(MDA_Gene_table_Weiss$Name, function(X)  strsplit(gsub("/mnt/isilon/maris_lab/target_nbl_ngs/MouseRNASeq_Weiss/quants/|.genes.results"," ",X), split=":")[[1]][1] )


ggplot(MDA_Gene_table_Weiss, aes(x=Name,y=TPM, fill=Gene)) + geom_bar(stat = "identity", position = "dodge")+
  theme_classic()+
  theme(axis.text.x = element_text(size=12, angle = 90,hjust = 1,vjust=0.5))+   #, color=X_Axis_colors))+
  theme(axis.text.y = element_text(size=12))+    #,color = c(rep("darkgreen",Splice_count),rep("black",NoSplice_count-3),rep("darkred",3))))+
  theme(axis.title.x = element_blank())

ggplot(MDA_Gene_table_Weiss, aes(x=Name,y=log10(TPM+1), fill=Gene)) + geom_bar(stat = "identity", position = "dodge")+
  theme_bw()+
  theme(axis.text.x = element_text(size=12, angle = 90,hjust = 1,vjust=0.5))+   #, color=X_Axis_colors))+
  theme(axis.text.y = element_text(size=12))+    #,color = c(rep("darkgreen",Splice_count),rep("black",NoSplice_count-3),rep("darkred",3))))+
  theme(axis.title.x = element_blank())+
  scale_y_continuous(breaks = c(0,1,2,3),labels = c(0,10,100,1000),limits = c(0,3))+
  ylab("TPM")




