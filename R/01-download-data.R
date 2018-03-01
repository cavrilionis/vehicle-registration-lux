
########## 01-download-data.R ##########

# Download XLSX
if (file.exists(file.path("input", "Parc_Automobile_201803.xlsx")) == FALSE)
{
  download.file(
    url = paste(
      "https://download.data.public.lu/resources/parc-automobile-du-luxembourg/",
      "20180301-095333/Parc_Automobile_201803.xlsx",
      sep = ""
    ),
    destfile = file.path("input", "Parc_Automobile_201803.xlsx"),
    method = "auto"
  )
}

# Download XML

if (file.exists(file.path("input", "Parc_Automobile_201803.xml")) == FALSE)
{
  download.file(
    url = paste(
      "https://download.data.public.lu/resources/parc-automobile-du-luxembourg/",
      "20180301-095026/Parc_Automobile_201803.xml",
      sep = ""
    ),
    destfile = file.path("input", "Parc_Automobile_201803.xml"),
    method = "auto"
  )
}

# Download XSD

if (file.exists(file.path("doc", "Parc_Automobile_v1.0.xsd")) == FALSE)
{
  download.file(
    url = paste(
      "https://download.data.public.lu/resources/demo-mddi-snca-parc-automobile/",
      "20170927-155043/Parc_Automobile_v1.0.xsd",
      sep = ""
    ),
    destfile = file.path("doc", "Parc_Automobile_v1.0.xsd"),
    method = "auto"
  )
}

# Download PDF

if (file.exists(file.path(
  "doc",
  "Description_des_Donnees_Exportees_vers_OpenData_v.1.2.pdf"
)) == FALSE)
{
  download.file(
    url = paste(
      "https://download.data.public.lu/resources/parc-automobile-du-luxembourg/",
      "20171117-133535/Description_des_Donnees_Exportees_vers_OpenData_v.1.2.pdf",
      sep = ""
    ),
    destfile = file.path(
      "doc",
      "Description_des_Donnees_Exportees_vers_OpenData_v.1.2.pdf"
    ),
    method = "auto"
  )
}
