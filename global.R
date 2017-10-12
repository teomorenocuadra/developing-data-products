# Loading the data

bd <- read.csv("bcn-deceased-50.csv", header = TRUE)

# Cleaning the data

bd <- bd[, -1]

# Ordering the factor variable Group

bd$Group <- factor(bd$Group, levels = bd$Group[order(bd$Order)])

