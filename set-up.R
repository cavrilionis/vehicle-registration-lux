
########## set-up.R ##########

# Required libraries

list.of.packages <-
  c("XML",
    "Hmisc",
    "pdftools",
    "stringr",
    "car",
    "dplyr",
    "tidyr",
    "padr",
    "utils",
	"openxlsx")

new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]

if (length(new.packages) > 0)
  install.packages(new.packages, dependencies = TRUE)

for (i in list.of.packages)
{
  library(i, character.only = TRUE)
}

getwd()
