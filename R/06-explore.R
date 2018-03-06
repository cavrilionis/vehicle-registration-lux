
cat("\014")
rm(list = ls())

########## 06-explore.R ##########

# Get dataset
load(file.path("input", "vehcln.RData"))

# Describe dataset
describe(vehcln)



### SAVAS ###


myCols <- as.vector(dict$Column.name[which(dict$Column.class == "character")])
myCols

for (i in seq_along(myCols)) {
  j <- paste0("vehcln$",myCols[i])
  print(table(j, useNA = "always"))
}



# Frequency tables


freq_plot <- function(col_name) {
  col_name <- enquo(col_name)
  temp <- summarise(group_by(vehcln, !!col_name), Freq = n())
  temp$Prop <- round(100 * prop.table(temp$Freq), 2)
  temp <- mutate(temp, Category = ifelse(temp$Prop <= 5, "Other", !!col_name))
  temp <- summarise(group_by(temp, Category), Freq = sum(Freq))
  temp$Prop <- round(100 * prop.table(temp$Freq), 2)
  temp$CumFreq <- cumsum(temp$Freq)
  temp$CumProp <- round(cumsum(temp$Prop), 1)
  label(temp$Freq) <- "Frequency"
  label(temp$CumFreq) <- "Cumulative frequency"
  label(temp$Prop) <- "Percent"
  label(temp$CumProp) <- "Cumulative percent"
  temp <- arrange(temp, desc(Freq))
  
  return(temp)  
}

CATSTC <- freq_plot(CATSTC)
CATSTC
View(CATSTC)


ggplot(data = CATSTC, aes(x = Category, y = Prop)) +
  geom_bar(stat = "identity") +
  xlab(label = NULL) +
  ylab(label = label(CATSTC$Prop)) +
  theme_hc() +
  theme(axis.ticks = element_blank()) +
  scale_y_continuous(limits = c(0, ceiling(max(CATSTC$Prop)) + (10 - ceiling(max(CATSTC$Prop)) %% 10))) +
  labs(title = label(vehcln$CATSTC),
       caption = "Category 'Other' groups categories where percent <= 5%")

ggsave(plot = last_plot(),
       path = "output",
       filename = "CATSTC.png")


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


# Mode (most frequent value) for nominal variables

# Summary statistics of continuous variables

# Histograms of continuous variables
