
#读取文件
A_data <- read.table("data.txt", header = T, row.names = 1)

#取整
A_data <- round(A_data, digits = 0)

#取log10
A_data <- log(A_data,10)

#添加颜色列
C_data <- read.table("color.txt",header = T)
A_data <- transform(A_data,colour = C_data)

library(dplyr)
library(ggplot2)

#计算
df <- A_data %>%
  mutate(fc = log2(CG / (Piwi)))
df$name <- rownames(A_data)

ggplot(A_data,aes(x=CG,y=Piwi,colour=colour)) +
  geom_point(size = 3) +
  geom_abline(slope = 1,intercept = 0,colour = "black") +
  # xlim(0,6) +  
  # ylim(0,6) +
  labs(x = "CG9754 KD [log10 rpm]", y = "Piwi KD [log10 rpm]", title = "steasy-state RNA(RNA-seq)") +
  theme(panel.grid =element_blank()) +
  geom_text(vjust = 0,nudge_x = -0.4,nudge_y = 0.4,size = 4,colour = "black",data = filter(df, fc < -0.29 , fc > -0.52), aes(CG, Piwi, label = name)) +
  scale_x_continuous(limits = c(0, 6), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 6), expand = c(0, 0)) +
  geom_abline(slope = 1,intercept = 0.3,lty = 2) +
  geom_abline(slope = 1,intercept = -0.3,lty = 2) +
  scale_colour_manual(values = c("gray","green","red","yellow")) +
  theme(legend.position = "none") +
  annotate("segment",x =	2.8044959 ,xend = 3.1344959 ,y = 4.7942017 ,yend = 4.4742017 ,colour = "black" ) +
  annotate("segment",x =	3.8344959 ,xend = 3.9887373 ,y = 5.311640 ,yend = 4.9011640 ,colour = "black" )

