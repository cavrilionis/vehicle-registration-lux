
########## 02-import-xml.R ##########

# Parse XML using package "XML"
doc <-
  xmlInternalTreeParse(file.path("input", "Parc_Automobile_201803.xml"))

# Parse XSD using package "XML"
xsd <-
  xmlParse(file.path("doc", "Parc_Automobile_v1.0.xsd"), isSchema = TRUE)

# Validate XML using XSD using package "XML"
out <- xmlSchemaValidate(schema = xsd, doc = doc)

out.status <- out["status"]
out.errors <- out["errors"]
out.warnings <- out["warnings"]

XMLValidationStatus <- as.data.frame(out.status)

XMLValidationErrors <- dplyr::as_data_frame(out.errors)

write.table(
  XMLValidationErrors,
  file = file.path("output", "XML-Validation-Errors.txt"),
  sep = "|"
)

# TODO: Count XML validation errors
# TODO: For colClasses use CSV instead of XLSX file

# Import colClasses
colClasses <-
  read.xlsx(file.path("doc", "colClasses.xlsx"),
            sheet = "Sheet2",
            colNames = TRUE)

# Convert XML to data frame using package "XML"
vehraw <-
  xmlToDataFrame(getNodeSet(doc, "//VEHICLE"),
                 colClasses = colClasses,
                 stringsAsFactors = FALSE)

# Get how many rows and columns the dataset has
cat("The dataset has",
    nrow(vehraw),
    "rows and",
    ncol(vehraw),
    "columns.\n")

# Save dataset
save(vehraw, file = file.path("input", "vehraw.RData"))
