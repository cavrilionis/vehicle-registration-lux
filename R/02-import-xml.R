
########## 02-import-xml.R ##########

# Parse XML using package "XML"
doc <-
  xmlInternalTreeParse(file.path("input", "Parc_Automobile_201803.xml"))

# Parse XSD using package "XML"
xsd <-
  xmlParse(file.path("doc", "Parc_Automobile_v1.0.xsd"), isSchema = TRUE)

# Validate XML using XSD using package "XML"
out <- xmlSchemaValidate(schema = xsd, doc = doc)

# Report XML Validation Errors

i <- 0L

for (i in 1:length(out[["errors"]])) {
  if (i == 1) {
    out.errors <- out[["errors"]][[i]][["msg"]]
  } else {
    out.errors <- c(out.errors, out[["errors"]][[i]][["msg"]])
  }
}

out.errors <- as.data.frame(out.errors)

out.errors.report <-
  as.data.frame(table(out.errors[1], useNA = "ifany"))

# out.errors.report$toto <- out.errors.report$Var1

out.errors.report$Error[which(substr(out.errors.report$Var1, 1, 39) == "Element 'LIBCRB': [facet 'enumeration']")] <-
  "LIBCRB 'ESSENCE / ETHANOL'\nis not an element in the\nXSD enumeration"

out.errors.report$Error[which(substr(out.errors.report$Var1, 1, 16) == "Element 'CODCRB'")] <-
  "Empty CODCRB"

out.errors.report$Error[which(substr(out.errors.report$Var1, 1, 37) == "Element 'LIBCRB': 'ESSENCE / ETHANOL'")] <-
  "'ESSENCE / ETHANOL'\nis not a valid value of the\nlocal atomic type"

xml.errors.report <- out.errors.report[, c(3, 2)]

suppressWarnings(
  print(
    ggplot(data = out.errors.report, aes(x = Error, y = Freq)) +
      geom_bar(stat = "identity") +
      ggtitle("XML validation errors") +
      scale_y_log10(
        name = "Frequency (log scale)",
        limits = c(NA, 1e5),
        labels = scales::comma
      ) +
      xlab(label = NULL) +
      theme_minimal() +
      theme(panel.grid.major.x = element_blank()) +
      scale_fill_few() +
      scale_x_discrete(
        limits = c(
          "Empty CODCRB",
          "LIBCRB 'ESSENCE / ETHANOL'\nis not an element in the\nXSD enumeration"
        )
      )
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
setClass('myDate') setAs("character", "myDate", function(from) as.Date(from, format = "%Y%m%d"))

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
save(xml.errors.report,
     file = file.path("output", "xml-validation-errors.RData"))

save(vehraw, file = file.path("input", "vehraw.RData"))

# Remove objects
rm("colClasses",
   "doc",
   "i",
   "out",
   "out.errors",
   "out.errors.report",
   "vehraw",
   "xsd")
