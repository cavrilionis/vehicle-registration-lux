
########## 05-explore.R ##########

# Get dataset
vehcln <- load(file.path("input", "vehcln.RData"))

# Describe dataset
describe(vehcln)

# Frequency tables

CATSTC2 <- summarise(group_by(vehcln, CATSTC), Freq = n())
CATSTC2$CumFreq <- cumsum(CATSTC2$Freq)
CATSTC2$Prop <- round(100 * prop.table(CATSTC2$Freq), 2)
CATSTC2$CumProp <- round(cumsum(CATSTC2$Prop), 1)
label(CATSTC2$Freq) <- "Frequency"
label(CATSTC2$CumFreq) <- "Cumulative frequency"
label(CATSTC2$Prop) <- "Percent"
label(CATSTC2$CumProp) <- "Cumulative percent"

CATSTC2

CATSTC2$CATSTC[which(CATSTC2$Prop < 5)] <- "Other"

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

