
########## 04-clean.R ##########

# Get dataset
vehcln <- get(load(file.path("input", "vehcol.RData")))

### OPE ###
# OPE is shown in the PDF but it is absent in the XSD and XML

### CATSTC ###
# Padding zeros to CATSTC
vehcln$CATSTC.v2 <- sprintf("%02d", as.integer(vehcln$CATSTC))
label(vehcln$CATSTC.v2) <- "Category Code Statec"

### LIBSTC ###
# Recoding CATSTC into LIBSTC
vehcln$LIBSTC <- recode(
  vehcln$CATSTC,
  '0' = 'Sans code',
  '1' = 'Cyclomoteur',
  '2' = 'Motocycle',
  '5' = 'Voiture particulière',
  '6' = 'Voiture à usage mixte',
  '7' = 'Véhicule utilitaire',
  '9' = 'Autobus - Autocar',
  '11' = 'Camionnette',
  '12' = 'Camion',
  '21' = 'Tracteur routier',
  '29' = 'Véhicule spécial',
  '31' = 'Tracteur agricole',
  '32' = 'Machine agricole',
  '39' = 'Auto véhicule automoteur',
  '41' = 'Remorque (marchandises)',
  '42' = 'Semi-remorque',
  '51' = 'Tricycle',
  '52' = 'Quadricycle',
  '53' = 'Quadricycle léger',
  '59' = 'Autre remorque',
  .default = "Autre"
)

label(vehcln$LIBSTC) <- "Category Label Statec"

# Verify that CATSTC.v2 and LIBSTC are calculated correctly
# arrange(summarise(group_by(vehcln, CATSTC, CATSTC.v2, LIBSTC), Count = n()), CATSTC.v2)

# Drop original CATSTC
vehcln <- select(vehcln, -CATSTC)

# Rename CATSTC.v2 to CATSTC
vehcln <- rename(vehcln, "CATSTC" = "CATSTC.v2")

### CODCAR ###
# No need for cleaning
# CODCAR = "ZZ" does not appear in the
# RÈGLEMENT (UE) No 678/2011 DE LA COMMISSION du 14 juillet 2011

### LIBCAR ###
# Some LIBCAR values are identical to CATSTC
# Set LIBCAR.v2 values where LIBCAR values are identical to CATSTC

vehcln$LIBCAR.v2 <- vehcln$LIBCAR

vehcln[which(vehcln$CODCAR == "AA"), "LIBCAR.v2"] <-
  str_to_upper("Berline")
vehcln[which(vehcln$CODCAR == "AB"), "LIBCAR.v2"] <-
  str_to_upper("Voiture à hayon arrière")
vehcln[which(vehcln$CODCAR == "AC"), "LIBCAR.v2"] <-
  str_to_upper("Break (familiale)")
vehcln[which(vehcln$CODCAR == "AD"), "LIBCAR.v2"] <-
  str_to_upper("Coupé")
vehcln[which(vehcln$CODCAR == "AE"), "LIBCAR.v2"] <-
  str_to_upper("Cabriolet")
vehcln[which(vehcln$CODCAR == "AF"), "LIBCAR.v2"] <-
  str_to_upper("Véhicule à usages multiples")
vehcln[which(vehcln$CODCAR == "AG"), "LIBCAR.v2"] <-
  str_to_upper("Break (commercial)")

vehcln[which(vehcln$CODCAR == "BA"), "LIBCAR.v2"] <-
  str_to_upper("Camion")
vehcln[which(vehcln$CODCAR == "BB"), "LIBCAR.v2"] <-
  str_to_upper("Camionnette")
vehcln[which(vehcln$CODCAR == "BC"), "LIBCAR.v2"] <-
  str_to_upper("Unité de traction pour semi-remorque")
vehcln[which(vehcln$CODCAR == "BD"), "LIBCAR.v2"] <-
  str_to_upper("Tracteur routier")
vehcln[which(vehcln$CODCAR == "BE"), "LIBCAR.v2"] <-
  str_to_upper("Camion pick-up")
vehcln[which(vehcln$CODCAR == "BX"), "LIBCAR.v2"] <-
  str_to_upper("Châssis-cabine ou châssis-capot")

vehcln[which(vehcln$CODCAR == "DA"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque")
vehcln[which(vehcln$CODCAR == "DB"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage")
vehcln[which(vehcln$CODCAR == "DC"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central")
vehcln[which(vehcln$CODCAR == "DE"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage rigide")

vehcln[which(vehcln$CODCAR == "BA01"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Plate-forme")
vehcln[which(vehcln$CODCAR == "BA02"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "BA03"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Fourgon")
vehcln[which(vehcln$CODCAR == "BA04"), "LIBCAR.v2"] <-
  str_to_upper(
    "Camion / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "BA06"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Bâchés")
vehcln[which(vehcln$CODCAR == "BA07"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Carrosserie amovible (superstructure interchangeable)")
vehcln[which(vehcln$CODCAR == "BA08"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Porte-conteneur")
vehcln[which(vehcln$CODCAR == "BA09"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Véhicules équipés d'une grue à crochet")
vehcln[which(vehcln$CODCAR == "BA10"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Benne basculante")
vehcln[which(vehcln$CODCAR == "BA11"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Citerne")
vehcln[which(vehcln$CODCAR == "BA12"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Citerne destinée au transport de marchandises dangereuses")
vehcln[which(vehcln$CODCAR == "BA13"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Bétaillère")
vehcln[which(vehcln$CODCAR == "BA14"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Transporteur de véhicules")
vehcln[which(vehcln$CODCAR == "BA17"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Transporteur de bois")
vehcln[which(vehcln$CODCAR == "BA19"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Balayeuse, véhicules de nettoyage et véhicules de curage de canalisations")
vehcln[which(vehcln$CODCAR == "BA24"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Dépanneuse")
vehcln[which(vehcln$CODCAR == "BA31"), "LIBCAR.v2"] <-
  str_to_upper("Camion / Véhicules d'incendie")

vehcln[which(vehcln$CODCAR == "BB04"), "LIBCAR.v2"] <-
  str_to_upper(
    "Camionnette / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "BB05"), "LIBCAR.v2"] <-
  str_to_upper(
    "Camionnette / Carrosserie aménagée au moyen de cloisons isolées mais pas d'équipements pour maintenir la température intérieure"
  )

vehcln[which(vehcln$CODCAR == "CA"), "LIBCAR.v2"] <-
  str_to_upper("Véhicule sans impériale")
vehcln[which(vehcln$CODCAR == "CB"), "LIBCAR.v2"] <-
  str_to_upper("Véhicule à impériale")
vehcln[which(vehcln$CODCAR == "CE"), "LIBCAR.v2"] <-
  str_to_upper("Véhicule surbaissé sans impériale")
vehcln[which(vehcln$CODCAR == "CG"), "LIBCAR.v2"] <-
  str_to_upper("Véhicule articulé surbaissé sans impériale")
vehcln[which(vehcln$CODCAR == "CI"), "LIBCAR.v2"] <-
  str_to_upper("Véhicule sans impériale à toit ouvert")
vehcln[which(vehcln$CODCAR == "CJ"), "LIBCAR.v2"] <-
  str_to_upper("Véhicule à impériale à toit ouvert")

vehcln[which(vehcln$CODCAR == "DA01"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Plate-forme")
vehcln[which(vehcln$CODCAR == "DA02"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "DA03"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Fourgon")
vehcln[which(vehcln$CODCAR == "DA04"), "LIBCAR.v2"] <-
  str_to_upper(
    "Semi-remorque / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "DA05"), "LIBCAR.v2"] <-
  str_to_upper(
    "Semi-remorque / Carrosserie aménagée au moyen de cloisons isolées mais pas d'équipements pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "DA06"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Bâchés")
vehcln[which(vehcln$CODCAR == "DA08"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Porte-conteneur")
vehcln[which(vehcln$CODCAR == "DA10"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Benne basculante")
vehcln[which(vehcln$CODCAR == "DA11"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Citerne")
vehcln[which(vehcln$CODCAR == "DA12"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Citerne destinée au transport de marchandises dangereuses")
vehcln[which(vehcln$CODCAR == "DA14"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Transporteur de véhicules")
vehcln[which(vehcln$CODCAR == "DA15"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Bétonneuse")
vehcln[which(vehcln$CODCAR == "DA16"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Véhicule pompe à béton")
vehcln[which(vehcln$CODCAR == "DA17"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Transporteur de bois")

vehcln[which(vehcln$CODCAR == "DA29"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Remorque surbaissée;")
vehcln[which(vehcln$CODCAR == "DA30"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Transporteur de vitrage")
vehcln[which(vehcln$CODCAR == "DA99"), "LIBCAR.v2"] <-
  str_to_upper("Semi-remorque / Carrosserie non incluse sur la présente liste")

vehcln[which(vehcln$CODCAR == "DB01"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage / Plate-forme")
vehcln[which(vehcln$CODCAR == "DB02"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "DB03"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage / Fourgon")
vehcln[which(vehcln$CODCAR == "DB06"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage / Bâchés")
vehcln[which(vehcln$CODCAR == "DB07"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage / Carrosserie amovible (superstructure interchangeable)")
vehcln[which(vehcln$CODCAR == "DB08"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage / Porte-conteneur")
vehcln[which(vehcln$CODCAR == "DB12"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage / Citerne destinée au transport de marchandises dangereuses")
vehcln[which(vehcln$CODCAR == "DB14"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage / Transporteur de véhicules")

vehcln[which(vehcln$CODCAR == "DC01"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Plate-forme")
vehcln[which(vehcln$CODCAR == "DC02"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "DC03"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Fourgon")
vehcln[which(vehcln$CODCAR == "DC04"), "LIBCAR.v2"] <-
  str_to_upper(
    "Remorque à essieu central / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "DC05"), "LIBCAR.v2"] <-
  str_to_upper(
    "Remorque à essieu central / Carrosserie aménagée au moyen de cloisons isolées mais pas d'équipements pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "DC06"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Bâchés")
vehcln[which(vehcln$CODCAR == "DC07"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Carrosserie amovible (superstructure interchangeable)")
vehcln[which(vehcln$CODCAR == "DC09"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Véhicules équipés d'une grue à crochet")
vehcln[which(vehcln$CODCAR == "DC10"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Benne basculante")
vehcln[which(vehcln$CODCAR == "DC13"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Bétaillère")
vehcln[which(vehcln$CODCAR == "DC14"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Transporteur de véhicules")
vehcln[which(vehcln$CODCAR == "DC16"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Véhicule pompe à béton")
vehcln[which(vehcln$CODCAR == "DC17"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Transporteur de bois")
vehcln[which(vehcln$CODCAR == "DC20"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Compresseur")
vehcln[which(vehcln$CODCAR == "DC21"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Porte-bateau")
vehcln[which(vehcln$CODCAR == "DC22"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Porte-planeur")
vehcln[which(vehcln$CODCAR == "DC23"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Véhicules pour commerce ambulant ou exposition itinérante")
vehcln[which(vehcln$CODCAR == "DC29"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Remorque surbaissée")
vehcln[which(vehcln$CODCAR == "DC99"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à essieu central / Carrosserie non incluse sur la présente liste")
vehcln[which(vehcln$CODCAR == "DE02"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage rigide / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "DE03"), "LIBCAR.v2"] <-
  str_to_upper("Remorque à timon d'attelage rigide / Fourgon")

vehcln[which(vehcln$CODCAR == "SA"), "LIBCAR.v2"] <-
  str_to_upper("Autocaravane")
vehcln[which(vehcln$CODCAR == "SB"), "LIBCAR.v2"] <-
  str_to_upper("Véhicule blindé")
vehcln[which(vehcln$CODCAR == "SC"), "LIBCAR.v2"] <-
  str_to_upper("Ambulance")
vehcln[which(vehcln$CODCAR == "SD"), "LIBCAR.v2"] <-
  str_to_upper("Corbillard")
vehcln[which(vehcln$CODCAR == "SE"), "LIBCAR.v2"] <-
  str_to_upper("Caravane")
vehcln[which(vehcln$CODCAR == "SF"), "LIBCAR.v2"] <-
  str_to_upper("Grue mobile")
vehcln[which(vehcln$CODCAR == "SG"), "LIBCAR.v2"] <-
  str_to_upper("Groupe spécial")
vehcln[which(vehcln$CODCAR == "SG18"), "LIBCAR.v2"] <-
  str_to_upper("Groupe spécial / Benne à ordures ménagères")

# LIBCAR = 'ZZ' does not apprear in the EU law. Set to missing. 
vehcln$LIBCAR[which(vehcln$CODCAR == "ZZ")] <- NA
vehcln$LIBCAR.v2[which(vehcln$CODCAR == "ZZ")] <- NA

# Data cleansing of LIBCAR.v2 where CODCAR = "393C"
vehcln[which(vehcln$CODCAR == "393C"), "LIBCAR.v2"] <-
  "EQUI. ELECT. / COMPRESSEUR"

CODCAR.LIBCAR <-
  arrange(summarise(group_by(vehcln, CODCAR, LIBCAR, LIBCAR.v2), Count = n()), CODCAR)

# Drop original LIBCAR
vehcln <- select(vehcln, -LIBCAR)

# Rename LIBCAR.v2 to LIBCAR
vehcln <- rename(vehcln, "LIBCAR" = "LIBCAR.v2")
label(vehcln$LIBCAR) <- "Bodywork wording"

### CATEU ###
vehcln$CATEU[which(vehcln$CATEU == "")] <- NA

### COUL ###
vehcln$COUL[which(vehcln$COUL == " ")] <- NA

### INDUTI ###
# No need for cleaning

### LIBUTI ###
# Recoding INDUTI into LIBUTI
vehcln$LIBUTI <- recode(
  vehcln$INDUTI,
  '0' = 'Neant',
  'A' = 'Ambulance',
  'C' = 'Location avec chauffeur',
  'D' = 'Depanneuse',
  'F' = "Vehicule d'instruction",
  'I' = 'Industriel',
  'L' = 'Location sans chauffeur',
  'M' = 'Motor-home',
  'P' = "Vehicule d'incendie",
  'R' = 'Ramassage scolaire',
  'S' = 'Vehicule de secours',
  'T' = 'Taxi',
  'X' = 'Mma >3500 (Catégorie 59)',
  'Z' = 'Vehicule forain',
  .default = "Autre"
)

label(vehcln$LIBUTI) <- "Indication of use label"

# Verify that LIBUTI is calculated correctly
# arrange(summarise(group_by(vehcln, INDUTI, LIBUTI), Count = n()), INDUTI)

### PAYPVN ###
# Values appear to be ISO 3166-1 alpha-2 codes
# Values 10, ZZ are not ISO 3166-1 alpha-2 codes. Set to missing
vehcln$PAYPVN[which(vehcln$PAYPVN %in% c("10", "ZZ", ""))] <- NA

### CODMRQ ###
# No need for cleaning

### LIBMRQ ###
vehcln$LIBMRQ[which(vehcln$LIBMRQ == " ")] <- NA

### TYPUSI ###
vehcln$TYPUSI[which(vehcln$TYPUSI == "")] <- NA

#### TYPCOM ###
vehcln$TYPCOM[which(vehcln$TYPCOM %in% c("", " "))] <- NA

### PVRNUM ###
# No need for cleaning

### PVRVAR ###
# No need for cleaning

### PVRVER ###
vehcln$PVRVER[which(vehcln$PVRVER %in% c("", " "))] <- NA

### DATCIRPRM ###
# No need for cleaning

### DATCIR_GD ###
# No need for cleaning

### DATCIR ###
# No need for cleaning

### DATHORCIR ###
# No need for cleaning
# All values are missing

### MVID ###
# No need for cleaning

### MMA ###
# No need for cleaning

### MMAENS ###
# No need for cleaning

### MMAATT ###
# No need for cleaning

### MMARSF ###
# No need for cleaning

### MMARAF ###
# No need for cleaning

### I4X4 ###
vehcln$I4X4[which(vehcln$I4X4 == "")] <- NA

### ABS ###
# No need for cleaning

### ASR ###
# No need for cleaning

### PLAAVA ###
# No need for cleaning

### PLAARR ###
# No need for cleaning

### PLASAV ###
# No need for cleaning

### PLASAR ###
# No need for cleaning

### PLADEB ###
# No need for cleaning

### PLAASS ###
# No need for cleaning

### LON ###
# No need for cleaning

### LAR ###
# No need for cleaning

### HAU ###
# No need for cleaning

### ESSIM ###
# No need for cleaning

### ESTAN ###
# No need for cleaning

### ESTRI ###
# No need for cleaning

### EMPMAX ###
# No need for cleaning

### LARES1 ###
# No need for cleaning

### LARES2 ###
# No need for cleaning

### TYPMOT ###
vehcln$TYPMOT[which(vehcln$TYPMOT %in% c("", " "))] <- NA

### CODCRB ###
vehcln$CODCRB[which(vehcln$CODCRB %in% c("", " "))] <- NA

### LIBCRB ###
vehcln$LIBCRB[which(vehcln$LIBCRB == "")] <- NA

### NBRCYL ###
# No need for cleaning

### PKW ###
# No need for cleaning

### CYD ###
# No need for cleaning

### INFOUTI ###
# No need for cleaning

### INFCO2 ###
# No need for cleaning

### L100KM ###
# No need for cleaning

### INFPARTICULE ###
# No need for cleaning

### INFNOX ###
vehcln$EUNORM[which(vehcln$EUNORM == "")] <- NA

# Identify duplicate rows
vehcln$dup <- duplicated(vehcln) 

paste("The dataset has",
      sum(vehcln$dup),
      "duplicate rows.")

# Reorder columns
vehcln <-  vehcln[c(
  "CATSTC",
  "LIBSTC",
  "CODCAR",
  "LIBCAR",
  "CATEU",
  "COUL",
  "INDUTI",
  "LIBUTI",
  "PAYPVN",
  "CODMRQ",
  "LIBMRQ",
  "TYPUSI",
  "TYPCOM",
  "PVRNUM",
  "PVRVAR",
  "PVRVER",
  "DATCIRPRM",
  "DATCIR_GD",
  "DATCIR",
  "DATHORCIR",
  "MVID",
  "MMA",
  "MMAENS",
  "MMAATT",
  "MMARSF",
  "MMARAF",
  "I4X4",
  "ABS",
  "ASR",
  "PLAAVA",
  "PLAARR",
  "PLASAV",
  "PLASAR",
  "PLADEB",
  "PLAASS",
  "LON",
  "LAR",
  "HAU",
  "ESSIM",
  "ESTAN",
  "ESTRI",
  "EMPMAX",
  "LARES1",
  "LARES2",
  "TYPMOT",
  "CODCRB",
  "LIBCRB",
  "NBRCYL",
  "PKW",
  "CYD",
  "INFOUTI",
  "INFCO2",
  "L100KM",
  "INFPARTICULE",
  "INFNOX",
  "EUNORM"
)]

paste("The dataset has",
      ncol(vehcln),
      "columns.")

paste("The dataset has",
      nrow(vehcln),
      "rows.")

paste("The dataset has",
      ncol(vehcln) * nrow(vehcln),
      "values.")

paste("The dataset has",
      sum(is.na(vehcln)),
      "missing values (",
      round(100 * sum(is.na(vehcln)) / (ncol(vehcln) * nrow(vehcln)), 1),
      "%).")

# Save dataset
save(vehcln, file = file.path("input", "vehcln.RData"))

# Remove objects
rm("CODCAR.LIBCAR",
   "vehcol",
   "vehcln"
)
