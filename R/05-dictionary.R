
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
dict.na$Pct.missing <-
  round(100 * dict.na$Count.missing / nrow(vehcln), 2)

# Gather all dictionary columns
dict <-
  bind_cols(dict.order,
            dict.labels,
            dict.class[2],
            dict.type[2],
            dict.n_distinct[2],
            dict.na[2:3])

# Count of distinct values excl. missing
dict$Count.distinct.excl.na <- dict$Count.distinct
dict$Count.distinct.excl.na <-
  ifelse(
    dict$Column.class != "character" &
      dict$Count.missing > 0,
    dict$Count.distinct - 1,
    dict$Count.distinct
  )

# Count of distinct values incl. missing
dict$Count.distinct.incl.na <- dict$Count.distinct
dict$Count.distinct.incl.na <-
  ifelse(
    dict$Column.class == "character" &
      dict$Count.missing > 0,
    dict$Count.distinct + 1,
    dict$Count.distinct
  )

dict <- select(dict, -Count.distinct)

# Column source
dict$Column.source <- "Raw"
dict$Column.source[which(dict$Column.name %in% c("LIBSTC", "LIBUTI"))] <-
  "Derived"

# Measurement
dict$Column.measurement <-
  ifelse(dict$Column.class == "character", "Nominal", "Continuous")

# Check that ABS and ASR have Class = logical, measurement = Nominal

# Role
dict$Column.role <-
  ifelse((
    dict$Column.class == "character" &
      dict$Count.distinct.excl.na >= 50
  ) | (dict$Column.class != "character" & dict$Pct.missing >= 50),
  "Rejected",
  "Input"
  )

dict <- upData(
  obj = dict,
  labels =
    c(
      Column.ID = "Column ID",
      Column.name = "Name",
      Column.label = "Label",
      Column.class = "Class",
      Column.type = "Type",
      Column.measurement = "Measurement",
      Count.distinct.incl.na = "Count of distinct values incl. missing",
      Count.distinct.excl.na = "Count of distinct values excl. missing",
      Count.missing = "Count of missing values",
      Pct.missing = "Percent of missing values",
      Column.source = "Source",
      Column.role = "Role"
    )
)

# Reorder columns
dict <-  dict[c(
  "Column.ID",
  "Column.name",
  "Column.label",
  "Column.class",
  "Column.type",
  "Column.measurement",
  "Count.distinct.incl.na",
  "Count.distinct.excl.na",
  "Count.missing",
  "Pct.missing",
  "Column.source",
  "Column.role"
)]

# Save dictionary
save(dict, file = file.path("doc", "data-dictionary.RData"))

# Remove objects
rm(
  "dict",
  "dict.class",
  "dict.labels",
  "dict.n_distinct",
  "dict.na",
  "dict.names",
  "dict.order",
  "dict.storage",
  "dict.type",
  "vehcln"
)
