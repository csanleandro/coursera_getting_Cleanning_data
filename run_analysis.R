##  run_analysis.R
## 1.- Merges the training and the test sets to create one data set.
## 2.- Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.- Uses descriptive activity names to name the activities in the data set
## 4.- Appropriately labels the data set with descriptive variable names.
## 5.- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Librerias que vamos a usar:
# We need dplyr package: install.packages("dplyr")
library(dplyr)

activ <- read.csv("activity_labels.txt",header=FALSE,sep=" ") #,stringsAsFactors=FALSE)
names(activ) <- c("cod_act", "activity")

features <- read.csv("features.txt",sep=" ",stringsAsFactors=FALSE,header=FALSE)
names(features) <- c("cod_feat","feature")
## renombro las variables, porque con parentesis y guiones son dificiles de usar
features$feature <- gsub("\\(|)","",features$feature)
features$feature <- gsub("-","_",features$feature)
##selecciono las variables que me interesan
u_features <- features$feature[grep("[Mm]ean|[Ss]td",features$feature)]


# Los y_test.txt indican la actividad
# Los subjet_test.txt indican el individuo
# Los x_test.txt son los datos
#
# Hay que  combinar (cbind) los tres ficheros, y luego unirlo al resultado de hacer
# lo mismo con os train (train:7352 muestras, test: 2947 muestras)

s_test <- read.csv("test/subject_test.txt",header=FALSE,sep=" ",stringsAsFactors=FALSE)
names(s_test) <- c("cod_subject")

act_test <- read.csv("test/y_test.txt",header=FALSE,sep=" ",stringsAsFactors=FALSE)
names(act_test) <- c("cod_act")

#En el fichero de datos el separador es uno o varios espacios, por eso indico ""
d_test <- read.csv("test/X_test.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
names(d_test) <- features$feature

#Agrupo todos los datos de test
# y me quedo solo con las variables que me interesan: mean y std:
d_test_c <- cbind(s_test,act_test,group="test",d_test[,u_features])

#Y ahora lo mismo con Train:
s_train <- read.csv("train/subject_train.txt",header=FALSE,sep=" ",stringsAsFactors=FALSE)
names(s_train ) <- c("cod_subject")

act_train <- read.csv("train/y_train.txt",header=FALSE,sep=" ",stringsAsFactors=FALSE)
names(act_train ) <- c("cod_act")

#En el fichero de datos el separador es uno o varios espacios, por eso indico ""
d_train <- read.csv("train/X_train.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
names(d_train ) <- features$feature

#Agrupo todos los datos de train
# y me quedo solo con las variables que me interesan: mean y std:
d_train_c <- cbind(s_train,act_train,group="train",d_train[,u_features])

# Y por ultimo uno los dos juegos de datos:
d_total <- rbind(d_test_c,d_train_c)

##Elimino los conjuntos de datos por suelto, que son pesados
rm(s_test)
rm(s_train)
rm(act_test)
rm(act_train)
rm(d_train)
rm(d_test)
rm(d_train_c)
rm(d_test_c)

# Me quedo solo con las variables que me interesan: mean y std:
#d_res <- d_total[,c(1,2,grep("mean|std",features$feature) +2)]

# cruzo con el catalogo de actividades para sacar la descripcion
d_total <- merge(activ,d_total,by.x="cod_act", by.y="cod_act")  %>% select(-cod_act)

# Final result:
d_final <- d_total %>%  select(-group) %>%   # we don't want cod_activity nor data group columns for this analysis
  group_by(activity,cod_subject)  %>%          # group by activity and subject
  summarise_all(funs(mean))                  # and get the mean of all variables


write.table(d_final, file="gett_clean_data_RES.txt", row.names=FALSE)