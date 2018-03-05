
cat("\014")
rm(list = ls())

########## 06-explore.R ##########

# Get dataset
load(file.path("input", "vehcln.RData"))

# Describe dataset
describe(vehcln)



### SAVAS ###


myCols <- dict$Column.ID[which(dict$Column.class == "character")]
myCols

for (i in seq_along(myCols)) {
  names((vehcln[i]) <- as.data.frame(table(vehcln[i]))
}



# Frequency tables

freq_plot <- function(col_name) {
  vehcln %>%
    group_by_(col_name) %>%
      summarise(Freq = n()) -> temp
  temp$CumFreq <- cumsum(temp$Freq)
  temp$Prop <- round(100 * prop.table(temp$Freq), 2)
  temp$CumProp <- round(cumsum(temp$Prop), 1)
  label(temp$Freq) <- "Frequency"
  label(temp$CumFreq) <- "Cumulative frequency"
  label(temp$Prop) <- "Percent"
  label(temp$CumProp) <- "Cumulative percent"
  temp <- arrange(temp, desc(Freq))
  return(temp)
}

CATSTC <- freq_plot('CATSTC')
LIBSTC <- freq_plot('LIBSTC')
CODCAR <- freq_plot('CODCAR')
LIBCAR <- freq_plot('LIBCAR')
CATEU  <- freq_plot('CATEU')
COUL   <- freq_plot('COUL')
INDUTI <- freq_plot('INDUTI')
LIBUTI <- freq_plot('LIBUTI')
PAYPVN <- freq_plot('PAYPVN')
CODMRQ <- freq_plot('CODMRQ')
LIBMRQ <- freq_plot('LIBMRQ')
TYPUSI <- freq_plot('TYPUSI')
TYPCOM <- freq_plot('TYPCOM')
PVRNUM <- freq_plot('PVRNUM')
PVRVAR <- freq_plot('PVRVAR')
PVRVER <- freq_plot('PVRVER')
I4X4   <- freq_plot('I4X4')
TYPMOT <- freq_plot('TYPMOT')
CODCRB <- freq_plot('CODCRB')
LIBCRB <- freq_plot('LIBCRB')
INFOUTI <- freq_plot('INFOUTI')
EUNORM  <- freq_plot('EUNORM')

num_cols <- select(filter(dict, Column.class != 'character'), Column.name)

paste(char_cols$Column.name, " <- ", "freq_plot('",char_cols$Column.name, "')", sep = "")




ggplot(data = vehcln, aes(x = CATSTC)) +
  geom_bar()

ggplot(data = CATSTC2, aes(x = CATSTC, y = Prop)) +
  geom_bar(stat = "identity")

ggsave(plot = last_plot(),
       path = "output",
       filename = "CATSTC.png")

# Mode (most frequent value) for nominal variables

# Summary statistics of continuous variables

# Histograms of continuous variables
