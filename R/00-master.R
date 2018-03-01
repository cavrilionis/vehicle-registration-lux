
########## 00-master.R ##########

# This is the master program which executes all the others

source(file.path("set-up.R"), echo = TRUE)

source(file.path("R", "01-download-data.R"), echo = TRUE)

source(file.path("R", "02-import-xml.R"), echo = TRUE)

source(file.path("R", "03-set-column-labels.R"), echo = TRUE)

source(file.path("R", "04-clean.R"), echo = TRUE)

source(file.path("R", "05-explore.R"), echo = TRUE)
