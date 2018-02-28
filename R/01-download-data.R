
########## 01-download-data.R ##########

# Download XML
download.file(
  url = paste(
    "https://download.data.public.lu/resources/parc-automobile-du-luxembourg/",
    "20180201-132600/Parc_Automobile_201802.xml",
    sep = ""
  ),
  destfile = file.path("input", "Parc_Automobile_201802.xml"),
  method = "auto"
)

# Download XSD
download.file(
  url = paste(
    "https://download.data.public.lu/resources/demo-mddi-snca-parc-automobile/",
    "20170927-155043/Parc_Automobile_v1.0.xsd",
    sep = ""
  ),
  destfile = file.path("doc", "Parc_Automobile_v1.0.xsd"),
  method = "auto"
)

# Download PDF
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
