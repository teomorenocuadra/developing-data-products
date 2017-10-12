# Getting and Cleaning the Data from Open Data BCN

# loading packages

library(downloader)

# downloading 2016 data

url <- "http://opendata-ajuntament.barcelona.cat/data/dataset/1b984fcc-0c28-4d21-a55b-5516764c2099/resource/de3a4b94-f61b-4078-b0ac-0cc47deab1dd/download/edq2016.csv"
filename <- "edq2016.csv"
download(url, destfile = filename)
bd2016 <- read.csv(filename)

# cleaning 2016 data

bd2016 <- bd2016[2:74, ]
bd2016 <- bd2016[, -3]
bd2016 <- bd2016[, -2]

# aggregating 2016 data by district

bd2016 <- aggregate(. ~ Dte., bd2016, sum)
bd2016$Dte. <- as.numeric(bd2016$Dte.)
bd2016 <- bd2016[with(bd2016, order(Dte.)), ]

# transposing 2016 data

m_bd2016 <- as.matrix(bd2016)
m_bd2016 <- t(m_bd2016)
df_bd2016 <- as.data.frame(m_bd2016)
df_bd2016 <- df_bd2016[-1, ]

# adding columns and labels to 2016 data

row.names(df_bd2016) <- NULL
v_group <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39",
             "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74",
             "75-79", "80-84", "85-89", "90-94", "95-99", "100+")
df_bd2016 <- cbind(v_group, df_bd2016)
v_year <- rep(2016, 21)
df_bd2016 <- cbind(df_bd2016, v_year)
v_order <- c(1:21)
df_bd2016 <- cbind(df_bd2016, v_order)
colnames(df_bd2016) <- c("Group", "Ciutat.Vella", "Eixample", "Sants.Motjuic",
                         "Les.Corts", "Sarria.Sant.Gervasi", "Gracia",
                         "Horta.Guinardo", "Nou.Barris", "Sant.Andreu", 
                         "Sant.Marti", "Year", "Order")

# subsetting the 2016 data 

df_bd2016_50 <- df_bd2016[11:21, ]
                         

# downloading 2015 data

url <- "http://opendata-ajuntament.barcelona.cat/data/dataset/1b984fcc-0c28-4d21-a55b-5516764c2099/resource/c0ac634f-383b-41c6-ba7d-2b932c3f0d64/download/2015_defuncions_edq.csv"
filename <- "2015_defuncions_edq.csv"
download(url, destfile = filename)
bd2015 <- read.csv(filename, sep = ";", skip = 22, header = FALSE)

# cleaning 2015 data

bd2015 <- bd2015[1:73, ]
bd2015 <- bd2015[, -3]
bd2015 <- bd2015[, -2]

# aggregating 2015 data by district

bd2015 <- aggregate(. ~ V1, bd2015, sum)

# transposing 2015 data

m_bd2015 <- as.matrix(bd2015)
m_bd2015 <- t(m_bd2015)
df_bd2015 <- as.data.frame(m_bd2015)
df_bd2015 <- df_bd2015[-1, ]

# adding columns and labels to 2015 data

row.names(df_bd2015) <- NULL
v_group <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39",
             "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74",
             "75-79", "80-84", "85-89", "90-94", "95-99", "100+")
df_bd2015 <- cbind(v_group, df_bd2015)
v_year <- rep(2015, 21)
df_bd2015 <- cbind(df_bd2015, v_year)
v_order <- c(1:21)
df_bd2015 <- cbind(df_bd2015, v_order)
colnames(df_bd2015) <- c("Group", "Ciutat.Vella", "Eixample", "Sants.Motjuic",
                         "Les.Corts", "Sarria.Sant.Gervasi", "Gracia",
                         "Horta.Guinardo", "Nou.Barris", "Sant.Andreu", 
                         "Sant.Marti", "Year", "Order")

# subsetting the 2015 data

df_bd2015_50 <- df_bd2015[11:21, ]

# merging 2016 and 2015 data

bcn_deceased <- rbind(df_bd2016, df_bd2015)
bcn_deceased_50 <- rbind(df_bd2016_50, df_bd2015_50)

# saving the merged data into a csv file

write.csv(bcn_deceased_50, "bcn-deceased-50.csv")
