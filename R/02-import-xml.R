
########## 02-import-xml.R ##########

# Parse XML using package "XML"
doc <-
  xmlInternalTreeParse(file.path("input", "Parc_Automobile_201803.xml"))

# Parse XSD using package "XML"
xsd <-
  xmlParse(file.path("doc", "Parc_Automobile_v1.0.xsd"), isSchema = TRUE)

# Validate XML using XSD using package "XML"
out <- xmlSchemaValidate(schema = xsd, doc = doc)
XMLValidationErrors <- as_data_frame(out["errors"])

write.table(
  XMLValidationErrors,
  file = file.path("output", "XML-Validation-Errors.txt"),
  sep = "|"
)

# Remove unnecessary line breaks manually in XML-Validation-Errors.txt
# and create a copy as XML-Validation-Errors-clean.txt

# Count XML validation errors

XML.vld.err <-
  read.delim(
    file.path("output", "XML-Validation-Errors-clean.txt"),
    header = TRUE,
    sep = "|"
  )

XML.vld.err <-
  mutate(
    XML.vld.err,
    Error.v2 = ifelse(
      substr(Error, 1, 27) == "list(msg = Element 'CODCRB'",
      "Empty CODCRB",
      ifelse(
        substr(Error, 1, 50) == "list(msg = Element 'LIBCRB': [facet 'enumeration']",
        "LIBCRB 'ESSENCE / ETHANOL' is not an element in the XSD enumeration",
        ifelse(
          substr(Error, 1, 95) == "list(msg = Element 'LIBCRB': 'ESSENCE / ETHANOL' is not a valid value of the local atomic type.",
          "LIBCRB 'ESSENCE / ETHANOL' is not a valid value of the local atomic type",
          NA
        )
      )
    )
  )

XML.vld.err <- select(XML.vld.err, -Error)
XML.vld.err <- rename(XML.vld.err, "Error" = "Error.v2")
save(XML.vld.err, file = file.path("output", "XML-Validation-Errors.RData"))

XML.vld.rpt <- as.data.frame(table(XML.vld.err$Error))
names(XML.vld.rpt) <- c("Error", "Frequency")
save(XML.vld.rpt, file = file.path("output", "XML-Validation-Report.RData"))

ggplot(data = XML.vld.err) +
  geom_bar(mapping = aes(Error)) +
  ggtitle("XML validation errors") +
  scale_y_log10(name = "Frequency", limits = c(NA, 1e5)) +
  coord_flip() +
  theme_minimal() +
  scale_fill_few() +
  scale_x_discrete(
    labels = c(
      "Empty CODCRB" = "Empty\nCODCRB",
      "LIBCRB 'ESSENCE / ETHANOL' is not an element in the XSD enumeration" = "LIBCRB 'ESSENCE / ETHANOL'\nis not an element in the\nXSD enumeration",
      "LIBCRB 'ESSENCE / ETHANOL' is not a valid value of the local atomic type" = "LIBCRB 'ESSENCE / ETHANOL'\nis not a valid value of the\nlocal atomic type"
    )
  )

ggsave(plot = last_plot(),
       path = "graphics",
       filename = "XML-validation-errors.png")

# Import colClasses
colClasses <-
  read.delim(file.path("doc", "colClasses.csv"), sep = "|")

colClasses <- as.vector(colClasses$Class)

# Create class to convert dates from character to date
setClass('myDate')
setAs("character", "myDate", function(from)
  as.Date(from, format = "%Y%m%d"))

# Convert XML to data frame using package "XML"
vehraw <-
  xmlToDataFrame(
    getNodeSet(doc, "//VEHICLE"),
    colClasses = colClasses,
    stringsAsFactors = FALSE,
    homogeneous = TRUE
  )

# Get the structure of the dataset
str(vehraw)

# Get how many rows and columns the dataset has
cat("The dataset has",
    nrow(vehraw),
    "rows and",
    ncol(vehraw),
    "columns.\n")

# Save dataset
save(vehraw, file = file.path("input", "vehraw.RData"))

# Remove objects
rm("colClasses",
   "doc",
   "out",
   "vehraw",
   "XMLValidationErrors",
   "XML.vld.err",
   "XML.vld.rpt",
   "xsd"
)
