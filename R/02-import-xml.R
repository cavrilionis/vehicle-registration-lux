
# Parse XML using package "XML"
doc <- xmlInternalTreeParse("Parc_Automobile_201802.xml")

# Parse XSD using package "XML"
xsd <- xmlParse("Parc_Automobile_v1.0.xsd", isSchema = TRUE)

# Validate XML using XSD using package "XML"
out <- xmlSchemaValidate(schema = xsd, doc = doc)

out.status <- out["status"]
out.errors <- out["errors"]
out.warnings <- out["warnings"]

XMLValidationStatus <- dplyr::as_data_frame(out.status)
View(XMLValidationStatus)

XMLValidationErrors <- dplyr::as_data_frame(out.errors)
View(XMLValidationErrors)

write.table(XMLValidationErrors, file = "XML-Validation-Errors.txt", sep = "|")

# Convert XML to data frame using package "XML"
vehicles <- xmlToDataFrame(getNodeSet(doc, "//VEHICLE"), stringsAsFactors = FALSE)

# Save dataset
save(vehicles, file = "vehicles.RData")

#View dataset
View(vehicles)

# Get how many rows and columns the dataset has
cat("The dataset has",
    nrow(vehicles),
    "rows and",
    ncol(vehicles),
    "columns.\n")
