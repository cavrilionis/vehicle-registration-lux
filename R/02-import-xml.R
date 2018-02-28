
########## 02-import-xml.R ##########

# Parse XML using package "XML"
doc <-
  xmlInternalTreeParse(file.path("input", "Parc_Automobile_201802.xml"))

# Parse XSD using package "XML"
xsd <-
  xmlParse(file.path("input", "Parc_Automobile_v1.0.xsd"), isSchema = TRUE)

# Validate XML using XSD using package "XML"
out <- xmlSchemaValidate(schema = xsd, doc = doc)

out.status <- out["status"]
out.errors <- out["errors"]
out.warnings <- out["warnings"]

XMLValidationStatus <- dplyr::as_data_frame(out.status)

XMLValidationErrors <- dplyr::as_data_frame(out.errors)

write.table(
  XMLValidationErrors,
  file = file.path("output", "XML-Validation-Errors.txt"),
  sep = "|"
)

# Convert XML to data frame using package "XML"
vehraw <-
  xmlToDataFrame(getNodeSet(doc, "//VEHICLE"), stringsAsFactors = FALSE)

#View dataset
View(vehraw)

# Get how many rows and columns the dataset has
cat("The dataset has",
    nrow(vehraw),
    "rows and",
    ncol(vehraw),
    "columns.\n")

# Save dataset
save(vehraw, file = file.path("input", "vehraw.RData"))
