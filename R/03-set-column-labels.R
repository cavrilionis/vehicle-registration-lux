
########## 03-set-column-labels.R ##########

# Get dataset
vehcol <- get(load(file.path("input", "vehraw.RData")))

# Check if column labels already exist
colnames(vehcol)
label(vehcol)

# The dataset vehcol does not have column labels

# Read column names and labels from external file
column_labels <- read.fwf(
  file = file.path("doc", "column_labels.txt"),
  widths = c(21, 51, 75),
  header = FALSE,
  col.names = c("Column.name", "Column.label.FR", "Column.label.EN")
)

# Deleting OPE because it is not in the dataset
column_labels <- column_labels[2:nrow(column_labels),]

# Adding column labels
Column.name <- as.vector(str_trim(column_labels[, 1]))
Column.label.EN <- as.vector(str_squish(column_labels[, 3]))
Column.label.EN
names(Column.label.EN) <- Column.name
vehcol <- upData(obj = vehcol, labels = Column.label.EN)

# Check new labels
label(vehcol)

# Save dataset
save(vehcol, file = file.path("input", "vehcol.RData"))

# Remove objects
rm("column_labels",
   "Column.label.EN",
   "Column.name",
   "vehcol",
   "vehraw"
)
