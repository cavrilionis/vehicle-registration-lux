
# Check column labels
colnames(vehicles)
label(vehicles)

# The dataset does not have column labels

# Read column names and labels from external file
column_labels <- read.fwf(
  file = "column_labels.txt",
  widths = c(21, 51, 75),
  header = FALSE,
  col.names = c("Column.name", "Column.label.FR", "Column.label.EN")
)

# Deleting OPE because it is not in the dataset
column_labels <- column_labels[2:nrow(column_labels),]

# Adding column labels
Column.name <- as.vector(str_trim(column_labels[, 1]))
Column.label.EN <- as.vector(column_labels[, 3])
names(Column.label.EN) <- Column.name
vehicles <- upData(obj = vehicles, labels = Column.label.EN)
label(vehicles)