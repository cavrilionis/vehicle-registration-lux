
########## set-up.R ##########

cat("\014")

# Required libraries

list.of.packages <-
  c("XML",
    "Hmisc",
    "pdftools",
    "stringr",
    "car",
    "dplyr",
    "padr",
    "utils")

new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]

if (length(new.packages) > 0)
  install.packages(new.packages, dependencies = TRUE)

for (i in list.of.packages)
{
  library(i, character.only = TRUE)
}

getwd()
