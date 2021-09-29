# Sources used for procedure:
# -> Normality, Boxplot, ANOVA, CHI https://www.youtube.com/watch?v=p2cSdQXSwPE&list=PLUohTJ4Lp9lHdbdFZr_QTUdE2HoxMsmKA&index=12
# -> Tukey-hsd https://www.real-statistics.com/one-way-analysis-of-variance-anova/unplanned-comparisons/tukey-hsd/

library(datarium)
library(dplyr)
library(rstatix)
library(ggrepel)
library(magick)
require(gtools)

#______Load the dataset______________
#1,2: 0, 5, 15, 30, 90
#3.4: 0%	3%	10%	30%	90%
setwd("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\r_files\\")
memory.size(max = 4095)
data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\3n_left_12_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\2n_left_12_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\1n_left_12_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\1n_mid_12_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\1n_right_12_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\2n_right_12_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\3n_right_12_data.csv", header=TRUE, stringsAsFactors=FALSE)

#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\3n_left_34_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\2n_left_34_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\1n_left_34_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\1n_mid_34_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\1n_right_34_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\2n_right_34_data.csv", header=TRUE, stringsAsFactors=FALSE)
#data <- read.csv("C:\\Users\\jpunr\\Documents\\Waterloo\\Hamza\\processed\\3n_right_34_data.csv", header=TRUE, stringsAsFactors=FALSE)
#Change experiment name so the plots are properly labelled when loading a new dataset 

experiment_name = "3n_left_12"; size_scale = 4; axis_scale = 0.5; index_names = c(" 0 minutes", " 5 minutes", " 15 minutes", " 30 minutes", " 90 minutes")
#experiment_name = "2n_left_12" size_scale = 2 axis_scale = 2 index_names = c(" 0 minutes", " 5 minutes", " 15 minutes", " 30 minutes", " 90 minutes")
#experiment_name = "1n_middle_12" size_scale = 2 axis_scale = 2 index_names = c(" 0 minutes", " 5 minutes", " 15 minutes", " 30 minutes", " 90 minutes")
#experiment_name = "1n_right_12" size_scale = 1 axis_scale = 4 index_names = c(" 0 minutes", " 5 minutes", " 15 minutes", " 30 minutes", " 90 minutes")
#experiment_name = "2n_right_12" size_scale = 2 axis_scale = 2 index_names = c(" 0 minutes", " 5 minutes", " 15 minutes", " 30 minutes2", " 90 minutes")
#experiment_name = "3n_right_12" size_scale = 4 axis_scale = 0.5 index_names = c(" 0 minutes2", " 5 minutes", " 15 minutes", " 30 minutes", " 90 minutes")

#experiment_name = "3n_left_34" size_scale = 4 axis_scale = 0.5 index_names = c(" 0 seconds", " 3 seconds", "10 seconds", " 30 seconds", " 90 seconds")
#experiment_name = "2n_left_34" size_scale = 2 axis_scale = 2 index_names = c(" 0 seconds", " 3 seconds", "10 seconds", " 30 seconds", " 90 seconds")
#experiment_name = "1n_left_34" size_scale = 1 axis_scale = 4 index_names = c(" 0 seconds", " 3 seconds", "10 seconds", " 30 seconds", " 90 seconds")
#experiment_name = "1n_middle_34" size_scale = 2 axis_scale = 2 index_names = c(" 0 seconds", " 3 seconds", "10 seconds", " 30 seconds", " 90 seconds")
#experiment_name = "1n_right_34" size_scale = 1 axis_scale = 4 index_names = c(" 0 seconds", " 3 seconds", "10 seconds", " 30 seconds", " 90 seconds")
#experiment_name = "2n_right_34" size_scale = 2 axis_scale = 2 index_names = c(" 0 seconds", " 3 seconds", "10 seconds", " 30 seconds", " 90 seconds")
#experiment_name = "3n_right_34" size_scale = 4 axis_scale = 0.5 index_names = c(" 0 seconds", " 3 seconds", "10 seconds", " 30 seconds", " 90 seconds")

#size_scale = 1 # 1 for 1n, 2 for 2n, 4 for 3n recommended plot scale
#axis_scale = 4 # 0.5 for 3n, 2 for 2n, 4 for 1n recommended axis scale

#View(data)

#_______Format data__________________

#data_replicates <- data_replicates[order(data_replicates$Amount),]
#data_delta <- data_delta[order(data_delta$Delta),]


#_______Normality of data____________
#data = sort(data)
plot(data$Delta)

#______SHOW DELTA____________________
p <- ggplot(data[order(data$Delta),], aes(x=reorder(Name,Delta), y = Delta)) + 
  geom_text(aes(label = Experiment), size = 3) +
  ggtitle( paste("Final deltas across replicates for: ", experiment_name, sep ="")) + # for the main title
  xlab("Dinucleotide Motif") + # for the x axis label
  ylab(" Relative Freqeuncy (%)") +
  theme(
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 8),
    axis.title.y = element_text(size = 16))

ggsave(file=paste(experiment_name,"_delta_exp.png",sep =""), width=5*size_scale, height=4, dpi=300)
#_____Boxplot to check for outliers__
png(paste(experiment_name,"_delta_box.png",sep =""))
boxplot(Delta~Name,data)
dev.off()

#____Generate some cool graphics_____

## create a directory to which the images will be written
#unlink(paste0(normalizePath(tempdir()), "/", dir(=tempdir())), recursive = TRUE)
#dir(tempdir())

dir_out <- file.path(tempdir(), "animated")
dir.create(dir_out, recursive = TRUE)

#C:\Users\junrau\AppData\Local\Temp\RtmpKkR5PS\animated

#_______Cant do for loop because of ugly r column handling behavior ):

#___________________X0_________________________________________________________
name_index = 1
p <- ggplot(data[order(data$Delta),], aes(x=reorder(Name,Delta),  y = X0_delta)) + 
  geom_text(aes(label = Experiment), size = 3) +
  scale_y_continuous(limits = c(-axis_scale, axis_scale)) +
  #Super long title code
  ggtitle(paste("Deltas across replicates for : ", paste(experiment_name,paste(index_names[name_index],paste(" Pr(>F): ", as.character(format(summary(aov(X0_delta~Name,data))[[1]][[1,"Pr(>F)"]], scientific = TRUE, digits = 3)), sep=""), sep =""), sep =""), sep ="")) + # for the main title
  xlab("Dinucleotide Motif") + # for the x axis label
  ylab("Relative Freqeuncy (%)") +
  theme(
    plot.title = element_text(size = 8*size_scale),
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 8),
    axis.title.y = element_text(size = 16))

fp <- file.path(dir_out, paste0(index_names[name_index], ".png"))

ggsave(plot = p, 
       filename = fp, 
       device = "png", width=5*size_scale, height=4, dpi=300)

#___________________X5/x3_________________________________________________________
name_index = 2
p <- ggplot(data[order(data$Delta),], aes(x=reorder(Name,Delta),  y = X5_delta)) + 
  geom_text(aes(label = Experiment), size = 3) +
  scale_y_continuous(limits = c(-axis_scale, axis_scale)) +
  ggtitle(paste("Deltas across replicates for : ", paste(experiment_name,paste(index_names[name_index],paste(" Pr(>F): ", as.character(format(summary(aov(X5_delta~Name,data))[[1]][[1,"Pr(>F)"]], scientific = TRUE, digits = 3)), sep=""), sep =""), sep =""), sep ="")) + # for the main title
  xlab("Dinucleotide Motif") + # for the x axis label
  ylab("Relative Freqeuncy (%)") +
  theme(
    plot.title = element_text(size = 8*size_scale),
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 8),
    axis.title.y = element_text(size = 16))

fp <- file.path(dir_out, paste0(index_names[name_index], ".png"))

ggsave(plot = p, 
       filename = fp, 
       device = "png", width=5*size_scale, height=4, dpi=300)

#___________________X15/x10_________________________________________________________
name_index = 3
p <- ggplot(data[order(data$Delta),], aes(x=reorder(Name,Delta),  y = X15_delta)) + 
  geom_text(aes(label = Experiment), size = 3) +
  scale_y_continuous(limits = c(-axis_scale, axis_scale)) +
  ggtitle(paste("Deltas across replicates for : ", paste(experiment_name,paste(index_names[name_index],paste(" Pr(>F): ", as.character(format(summary(aov(X15_delta~Name,data))[[1]][[1,"Pr(>F)"]], scientific = TRUE, digits = 3)), sep=""), sep =""), sep =""), sep ="")) + # for the main title
  xlab("Dinucleotide Motif") + # for the x axis label
  ylab("Relative Freqeuncy (%)") +
  theme(
    plot.title = element_text(size = 8*size_scale),
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 8),
    axis.title.y = element_text(size = 16))

fp <- file.path(dir_out, paste0(index_names[name_index], ".png"))

ggsave(plot = p, 
       filename = fp, 
       device = "png", width=5*size_scale, height=4, dpi=300)

#___________________X30_________________________________________________________
name_index = 4
p <- ggplot(data[order(data$Delta),], aes(x=reorder(Name,Delta),  y = X30_delta)) + 
  geom_text(aes(label = Experiment), size = 3) +
  scale_y_continuous(limits = c(-axis_scale, axis_scale)) +
  ggtitle(paste("Deltas across replicates for : ", paste(experiment_name,paste(index_names[name_index],paste(" Pr(>F): ", as.character(format(summary(aov(X30_delta~Name,data))[[1]][[1,"Pr(>F)"]], scientific = TRUE, digits = 3)), sep=""), sep =""), sep =""), sep ="")) + # for the main title
  xlab("Dinucleotide Motif") + # for the x axis label
  ylab("Relative Freqeuncy (%)") +
  theme(
    plot.title = element_text(size = 8*size_scale),
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 8),
    axis.title.y = element_text(size = 16))

fp <- file.path(dir_out, paste0(index_names[name_index], ".png"))

ggsave(plot = p, 
       filename = fp, 
       device = "png", width=5*size_scale, height=4, dpi=300)

#___________________X90_________________________________________________________
name_index = 5
p <- ggplot(data[order(data$Delta),], aes(x=reorder(Name,Delta),  y = X90_delta)) + 
  geom_text(aes(label = Experiment), size = 3) +
  scale_y_continuous(limits = c(-axis_scale, axis_scale)) +
  ggtitle(paste("Deltas across replicates for : ", paste(experiment_name,paste(index_names[name_index],paste(" Pr(>F): ", as.character(format(summary(aov(X90_delta~Name,data))[[1]][[1,"Pr(>F)"]], scientific = TRUE, digits = 3)), sep=""), sep =""), sep =""), sep ="")) + # for the main title
  xlab("Dinucleotide Motif") + # for the x axis label
  ylab("Relative Freqeuncy (%)") +
  theme(
    plot.title = element_text(size = 8*size_scale),
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 8),
    axis.title.y = element_text(size = 16))

fp <- file.path(dir_out, paste0(index_names[name_index], ".png"))

ggsave(plot = p, 
       filename = fp, 
       device = "png", width=5*size_scale, height=4, dpi=300)





## list file names and read in
imgs <- list.files(dir_out, full.names = TRUE)
imgs <- mixedsort(imgs)
print(imgs)
img_list <- lapply(imgs, image_read)

## join the images together
img_joined <- image_join(img_list)

## animate
img_animated <- image_animate(img_joined, fps = 1)

if (file.exists("delta_animated.gif")) {
  #Delete file if it exists
  file.remove("delta_animated.gif")
}

## save to disk
#image_write(image = img_animated, path = paste(experiment_name,"_delta_animated.gif",sep =""))

#_______ANOVA________________________
result <- aov(Delta ~ Name + Experiment:Delta,data)
summary(result)
result <- aov(Delta ~ Name + Experiment,data)
summary(result)
result <- aov(Delta ~ Experiment * Name,data)
summary(result)
result <- aov(Delta ~ Name, data)
summary(result)

#_______CHI Squared (NOT NEEDED)_____

#kruskal.test(Amount~Name,data)

#_______Find Significant Group_______

tukey_hsd(result, "Name")
hsd <- tukey_hsd(result, "Name")