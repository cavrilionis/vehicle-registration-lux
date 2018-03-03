
cat("\014")
rm(list = ls())

########## 05-dictionary.R ##########

# Get dataset
load(file.path("input", "vehcln.RData"))

# Name
dict.names <- as.data.frame(colnames(vehcln))
names(dict.names) <- "Column.name"

# Order
dict.order <- rownames_to_column(dict.names, var = "Column.ID")

# Label
dict.labels <- as.data.frame(label(vehcln))
row.names(dict.labels) <- NULL
names(dict.labels) <- "Column.label"

# Type
dict.type <- as.data.frame(lapply(vehcln, typeof))
dict.type <- as.data.frame(t(dict.type))
dict.type <- rownames_to_column(dict.type, var = "Column.name")
dict.type <- rename(dict.type, "Column.type" = "V1")

# Class
dict.class <- as.data.frame(lapply(vehcln, class))
dict.class <- as.data.frame(t(dict.class))
dict.class <- rownames_to_column(dict.class, var = "Column.name")
dict.class <- select(dict.class, -V1)
dict.class <- rename(dict.class, "Column.class" = "V2")

# Storage mode
dict.storage <- as.data.frame(lapply(vehcln, storage.mode))
dict.storage <- as.data.frame(t(dict.storage))
dict.storage <-
  rownames_to_column(dict.storage, var = "Column.name")
dict.storage <- rename(dict.storage, "Column.storage" = "V1")

# Count of distinct values
dict.n_distinct <- as.data.frame(lapply(vehcln, n_distinct))
dict.n_distinct <- as.data.frame(t(dict.n_distinct))
dict.n_distinct <-
  rownames_to_column(dict.n_distinct, var = "Column.name")
dict.n_distinct <- rename(dict.n_distinct, "Count.distinct" = "V1")

# Missing values
dict.na <- as.data.frame(lapply(vehcln, is.na))
dict.na <- summarise_all(dict.na, sum)
dict.na <- as.data.frame(t(dict.na))
dict.na <-
  rownames_to_column(dict.na, var = "Column.name")
dict.na <- rename(dict.na, "Count.missing" = "V1")
dict.na$Pct.missing <- round(100 * dict.na$Count.missing / nrow(vehcln),2)

# Gather all dictionary columns
dict <-
  bind_cols(
    dict.order,
    dict.labels,
    dict.class[2],
    dict.type[2],
    dict.n_distinct[2],
    dict.na[2:3]
  )

# Count of distinct values excl. missing
dict$Count.distinct.excl.na <- dict$Count.distinct
dict$Count.distinct.excl.na <- ifelse(dict$Column.class != "character" & dict$Count.missing > 0, dict$Count.distinct - 1, dict$Count.distinct)

# Count of distinct values incl. missing
dict$Count.distinct.incl.na <- dict$Count.distinct
dict$Count.distinct.incl.na <- ifelse(dict$Column.class == "character" & dict$Count.missing > 0, dict$Count.distinct + 1, dict$Count.distinct)

dict <- select(dict,-Count.distinct)

dict <- upData(
  obj = dict,
  labels =
    c(
      Column.ID = "Column ID",
      Column.name = "Name",
      Column.label = "Label",
      Column.class = "Class",
      Column.type = "Type",
      Count.distinct.incl.na = "Count of distinct values incl. missing",
      Count.distinct.excl.na = "Count of distinct values excl. missing",
      Count.missing = "Count of missing values",
      Pct.missing = "Percent of missing values"
    )
)

# Reorder columns
dict <-  dict[c(
  "Column.ID",
  "Column.name",
  "Column.label",
  "Column.class",
  "Column.type",
  "Count.distinct.incl.na",
  "Count.distinct.excl.na",
  "Count.missing",
  "Pct.missing"
)]

View(dict)



### SAVAS ###

# Source

str(vehcln)

for (i in 1:ncol(vehcln)){
  cat("attributes(vehcln$",names(vehcln[i]),")$source <- 'Raw'\n",sep = "")
}

attributes(vehcln$CATSTC)$source <- 'Raw'
attributes(vehcln$LIBSTC)$source <- 'Derived'
attributes(vehcln$CODCAR)$source <- 'Raw'
attributes(vehcln$LIBCAR)$source <- 'Raw'
attributes(vehcln$CATEU)$source <- 'Raw'
attributes(vehcln$COUL)$source <- 'Raw'
attributes(vehcln$INDUTI)$source <- 'Raw'
attributes(vehcln$PAYPVN)$source <- 'Raw'
attributes(vehcln$CODMRQ)$source <- 'Raw'
attributes(vehcln$LIBMRQ)$source <- 'Raw'
attributes(vehcln$TYPUSI)$source <- 'Raw'
attributes(vehcln$TYPCOM)$source <- 'Raw'
attributes(vehcln$PVRNUM)$source <- 'Raw'
attributes(vehcln$PVRVAR)$source <- 'Raw'
attributes(vehcln$PVRVER)$source <- 'Raw'
attributes(vehcln$DATCIRPRM)$source <- 'Raw'
attributes(vehcln$DATCIR_GD)$source <- 'Raw'
attributes(vehcln$DATCIR)$source <- 'Raw'
attributes(vehcln$DATHORCIR)$source <- 'Raw'
attributes(vehcln$MVID)$source <- 'Raw'
attributes(vehcln$MMA)$source <- 'Raw'
attributes(vehcln$MMAENS)$source <- 'Raw'
attributes(vehcln$MMAATT)$source <- 'Raw'
attributes(vehcln$MMARSF)$source <- 'Raw'
attributes(vehcln$MMARAF)$source <- 'Raw'
attributes(vehcln$I4X4)$source <- 'Raw'
attributes(vehcln$ABS)$source <- 'Raw'
attributes(vehcln$ASR)$source <- 'Raw'
attributes(vehcln$PLAAVA)$source <- 'Raw'
attributes(vehcln$PLAARR)$source <- 'Raw'
attributes(vehcln$PLASAV)$source <- 'Raw'
attributes(vehcln$PLASAR)$source <- 'Raw'
attributes(vehcln$PLADEB)$source <- 'Raw'
attributes(vehcln$PLAASS)$source <- 'Raw'
attributes(vehcln$LON)$source <- 'Raw'
attributes(vehcln$LAR)$source <- 'Raw'
attributes(vehcln$HAU)$source <- 'Raw'
attributes(vehcln$ESSIM)$source <- 'Raw'
attributes(vehcln$ESTAN)$source <- 'Raw'
attributes(vehcln$ESTRI)$source <- 'Raw'
attributes(vehcln$EMPMAX)$source <- 'Raw'
attributes(vehcln$LARES1)$source <- 'Raw'
attributes(vehcln$LARES2)$source <- 'Raw'
attributes(vehcln$TYPMOT)$source <- 'Raw'
attributes(vehcln$CODCRB)$source <- 'Raw'
attributes(vehcln$LIBCRB)$source <- 'Raw'
attributes(vehcln$NBRCYL)$source <- 'Raw'
attributes(vehcln$PKW)$source <- 'Raw'
attributes(vehcln$CYD)$source <- 'Raw'
attributes(vehcln$INFOUTI)$source <- 'Raw'
attributes(vehcln$INFCO2)$source <- 'Raw'
attributes(vehcln$L100KM)$source <- 'Raw'
attributes(vehcln$INFPARTICULE)$source <- 'Raw'
attributes(vehcln$INFNOX)$source <- 'Raw'
attributes(vehcln$EUNORM)$source <- 'Raw'

str(vehcln)
attr(vehcln$LIBSTC,"source")

for (i in seq(1,ncol(vehcln))){
  tmp <- attr(vehcln$names(vehcln[i]),"source")
  dict.source <- c(dict.source, tmp)
}


# attr(MyData$VAR, "ATT") <- NULL

# Measurement
attributes(vehcln$INFNOX)$measurement <- "Continuous"
