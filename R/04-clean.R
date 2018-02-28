
vehicles.v2 <- vehicles


# Recoding CATSTC into LIBSTC
vehicles$LIBSTC <- car::recode(
  vehicles$CATSTC,
  "
  0 = 'Sans code';
  1 = 'Cyclomoteur';
  2 = 'Motocycle';
  5 = 'Voiture particulière';
  6 = 'Voiture à usage mixte';
  7 = 'Véhicule utilitaire';
  9 = 'Autobus - Autocar';
  11 = 'Camionnette';
  12 = 'Camion';
  21 = 'Tracteur routier';
  29 = 'Véhicule spécial';
  31 = 'Tracteur agricole';
  32 = 'Machine agricole';
  39 = 'Auto véhicule automoteur';
  41 = 'Remorque (marchandises)';
  42 = 'Semi-remorque';
  51 = 'Tricycle';
  52 = 'Quadricycle';
  53 = 'Quadricycle léger';
  59 = 'Autre remorque';
  "
)

# Changing type of CATSTC from int to char
typeof(vehicles$CATSTC)

# Padding CATSTC
vehicles$CATSTC.v2 <- sprintf("%02s", vehicles$CATSTC)
typeof(vehicles$CATSTC.v2)

label(vehicles$CATSTC.v2) <- "Category Code Statec"

label(vehicles$LIBSTC) <- "Category Label Statec"

# Verify that CATSTC.v2 and LIBSTC are calculated correctly
arrange(summarize(group_by(vehicles, CATSTC.v2, CATSTC, LIBSTC), Count = n()), CATSTC.v2)

# Drop original CATSTC
vehicles <- select(vehicles, -CATSTC)

# Rename CATSTC.v2 to CATSTC
names(vehicles)[names(vehicles) == "CATSTC.v2"] <- "CATSTC"

# Set LIBCAR values where needed

vehicles$LIBCAR.v2 <- as.vector(vehicles$LIBCAR)

vehicles[which(vehicles$CODCAR == "AA"), 56] <-
  str_to_upper("Berline")
vehicles[which(vehicles$CODCAR == "AB"), 56] <-
  str_to_upper("Voiture à hayon arrière")
vehicles[which(vehicles$CODCAR == "AC"), 56] <-
  str_to_upper("Break (familiale)")
vehicles[which(vehicles$CODCAR == "AD"), 56] <-
  str_to_upper("Coupé")
vehicles[which(vehicles$CODCAR == "AE"), 56] <-
  str_to_upper("Cabriolet")
vehicles[which(vehicles$CODCAR == "AF"), 56] <-
  str_to_upper("Véhicule à usages multiples")
vehicles[which(vehicles$CODCAR == "AG"), 56] <-
  str_to_upper("Break (commercial)")

vehicles[which(vehicles$CODCAR == "BA"), 56] <-
  str_to_upper("Camion")
vehicles[which(vehicles$CODCAR == "BB"), 56] <-
  str_to_upper("Camionnette")
vehicles[which(vehicles$CODCAR == "BC"), 56] <-
  str_to_upper("Unité de traction pour semi-remorque")
vehicles[which(vehicles$CODCAR == "BD"), 56] <-
  str_to_upper("Tracteur routier")
vehicles[which(vehicles$CODCAR == "BE"), 56] <-
  str_to_upper("Camion pick-up")
vehicles[which(vehicles$CODCAR == "BX"), 56] <-
  str_to_upper("Châssis-cabine ou châssis-capot")

vehicles[which(vehicles$CODCAR == "DA"), 56] <-
  str_to_upper("Semi-remorque")
vehicles[which(vehicles$CODCAR == "DB"), 56] <-
  str_to_upper("Remorque à timon d'attelage")
vehicles[which(vehicles$CODCAR == "DC"), 56] <-
  str_to_upper("Remorque à essieu central")
vehicles[which(vehicles$CODCAR == "DE"), 56] <-
  str_to_upper("Remorque à timon d'attelage rigide")

vehicles[which(vehicles$CODCAR == "BA01"), 56] <-
  str_to_upper("Camion / Plate-forme")
vehicles[which(vehicles$CODCAR == "BA02"), 56] <-
  str_to_upper("Camion / Ridelle rabattable")
vehicles[which(vehicles$CODCAR == "BA03"), 56] <-
  str_to_upper("Camion / Fourgon")
vehicles[which(vehicles$CODCAR == "BA04"), 56] <-
  str_to_upper(
    "Camion / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehicles[which(vehicles$CODCAR == "BA06"), 56] <-
  str_to_upper("Camion / Bâchés")
vehicles[which(vehicles$CODCAR == "BA07"), 56] <-
  str_to_upper("Camion / Carrosserie amovible (superstructure interchangeable)")
vehicles[which(vehicles$CODCAR == "BA08"), 56] <-
  str_to_upper("Camion / Porte-conteneur")
vehicles[which(vehicles$CODCAR == "BA09"), 56] <-
  str_to_upper("Camion / Véhicules équipés d'une grue à crochet")
vehicles[which(vehicles$CODCAR == "BA10"), 56] <-
  str_to_upper("Camion / Benne basculante")
vehicles[which(vehicles$CODCAR == "BA11"), 56] <-
  str_to_upper("Camion / Citerne")
vehicles[which(vehicles$CODCAR == "BA12"), 56] <-
  str_to_upper("Camion / Citerne destinée au transport de marchandises dangereuses")
vehicles[which(vehicles$CODCAR == "BA13"), 56] <-
  str_to_upper("Camion / Bétaillère")
vehicles[which(vehicles$CODCAR == "BA14"), 56] <-
  str_to_upper("Camion / Transporteur de véhicules")
vehicles[which(vehicles$CODCAR == "BA17"), 56] <-
  str_to_upper("Camion / Transporteur de bois")
vehicles[which(vehicles$CODCAR == "BA19"), 56] <-
  str_to_upper("Camion / Balayeuse, véhicules de nettoyage et véhicules de curage de canalisations")
vehicles[which(vehicles$CODCAR == "BA24"), 56] <-
  str_to_upper("Camion / Dépanneuse")
vehicles[which(vehicles$CODCAR == "BA31"), 56] <-
  str_to_upper("Camion / Véhicules d'incendie")

vehicles[which(vehicles$CODCAR == "BB04"), 56] <-
  str_to_upper(
    "Camionnette / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehicles[which(vehicles$CODCAR == "BB05"), 56] <-
  str_to_upper(
    "Camionnette / Carrosserie aménagée au moyen de cloisons isolées mais pas d'équipements pour maintenir la température intérieure"
  )

vehicles[which(vehicles$CODCAR == "CA"), 56] <-
  str_to_upper("Véhicule sans impériale")
vehicles[which(vehicles$CODCAR == "CB"), 56] <-
  str_to_upper("Véhicule à impériale")
vehicles[which(vehicles$CODCAR == "CE"), 56] <-
  str_to_upper("Véhicule surbaissé sans impériale")
vehicles[which(vehicles$CODCAR == "CG"), 56] <-
  str_to_upper("Véhicule articulé surbaissé sans impériale")
vehicles[which(vehicles$CODCAR == "CI"), 56] <-
  str_to_upper("Véhicule sans impériale à toit ouvert")
vehicles[which(vehicles$CODCAR == "CJ"), 56] <-
  str_to_upper("Véhicule à impériale à toit ouvert")

vehicles[which(vehicles$CODCAR == "DA01"), 56] <-
  str_to_upper("Semi-remorque / Plate-forme")
vehicles[which(vehicles$CODCAR == "DA02"), 56] <-
  str_to_upper("Semi-remorque / Ridelle rabattable")
vehicles[which(vehicles$CODCAR == "DA03"), 56] <-
  str_to_upper("Semi-remorque / Fourgon")
vehicles[which(vehicles$CODCAR == "DA04"), 56] <-
  str_to_upper(
    "Semi-remorque / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehicles[which(vehicles$CODCAR == "DA05"), 56] <-
  str_to_upper(
    "Semi-remorque / Carrosserie aménagée au moyen de cloisons isolées mais pas d'équipements pour maintenir la température intérieure"
  )
vehicles[which(vehicles$CODCAR == "DA06"), 56] <-
  str_to_upper("Semi-remorque / Bâchés")
vehicles[which(vehicles$CODCAR == "DA08"), 56] <-
  str_to_upper("Semi-remorque / Porte-conteneur")
vehicles[which(vehicles$CODCAR == "DA10"), 56] <-
  str_to_upper("Semi-remorque / Benne basculante")
vehicles[which(vehicles$CODCAR == "DA11"), 56] <-
  str_to_upper("Semi-remorque / Citerne")
vehicles[which(vehicles$CODCAR == "DA12"), 56] <-
  str_to_upper("Semi-remorque / Citerne destinée au transport de marchandises dangereuses")
vehicles[which(vehicles$CODCAR == "DA14"), 56] <-
  str_to_upper("Semi-remorque / Transporteur de véhicules")
vehicles[which(vehicles$CODCAR == "DA15"), 56] <-
  str_to_upper("Semi-remorque / Bétonneuse")
vehicles[which(vehicles$CODCAR == "DA16"), 56] <-
  str_to_upper("Semi-remorque / Véhicule pompe à béton")
vehicles[which(vehicles$CODCAR == "DA17"), 56] <-
  str_to_upper("Semi-remorque / Transporteur de bois")

vehicles[which(vehicles$CODCAR == "DA29"), 56] <-
  str_to_upper("Semi-remorque / Remorque surbaissée;")
vehicles[which(vehicles$CODCAR == "DA30"), 56] <-
  str_to_upper("Semi-remorque / Transporteur de vitrage")
vehicles[which(vehicles$CODCAR == "DA99"), 56] <-
  str_to_upper("Semi-remorque / Carrosserie non incluse sur la présente liste")

vehicles[which(vehicles$CODCAR == "DB01"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Plate-forme")
vehicles[which(vehicles$CODCAR == "DB02"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Ridelle rabattable")
vehicles[which(vehicles$CODCAR == "DB03"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Fourgon")
vehicles[which(vehicles$CODCAR == "DB06"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Bâchés")
vehicles[which(vehicles$CODCAR == "DB07"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Carrosserie amovible (superstructure interchangeable)")
vehicles[which(vehicles$CODCAR == "DB08"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Porte-conteneur")
vehicles[which(vehicles$CODCAR == "DB12"), 56] <-
  str_to_upper(
    "Remorque à timon d'attelage / Citerne destinée au transport de marchandises dangereuses"
  )
vehicles[which(vehicles$CODCAR == "DB14"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Transporteur de véhicules")

vehicles[which(vehicles$CODCAR == "DC01"), 56] <-
  str_to_upper("Remorque à essieu central / Plate-forme")
vehicles[which(vehicles$CODCAR == "DC02"), 56] <-
  str_to_upper("Remorque à essieu central / Ridelle rabattable")
vehicles[which(vehicles$CODCAR == "DC03"), 56] <-
  str_to_upper("Remorque à essieu central / Fourgon")
vehicles[which(vehicles$CODCAR == "DC04"), 56] <-
  str_to_upper(
    "Remorque à essieu central / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehicles[which(vehicles$CODCAR == "DC05"), 56] <-
  str_to_upper(
    "Remorque à essieu central / Carrosserie aménagée au moyen de cloisons isolées mais pas d'équipements pour maintenir la température intérieure"
  )
vehicles[which(vehicles$CODCAR == "DC06"), 56] <-
  str_to_upper("Remorque à essieu central / Bâchés")
vehicles[which(vehicles$CODCAR == "DC07"), 56] <-
  str_to_upper("Remorque à essieu central / Carrosserie amovible (superstructure interchangeable)")
vehicles[which(vehicles$CODCAR == "DC09"), 56] <-
  str_to_upper("Remorque à essieu central / Véhicules équipés d'une grue à crochet")
vehicles[which(vehicles$CODCAR == "DC10"), 56] <-
  str_to_upper("Remorque à essieu central / Benne basculante")
vehicles[which(vehicles$CODCAR == "DC13"), 56] <-
  str_to_upper("Remorque à essieu central / Bétaillère")
vehicles[which(vehicles$CODCAR == "DC14"), 56] <-
  str_to_upper("Remorque à essieu central / Transporteur de véhicules")
vehicles[which(vehicles$CODCAR == "DC16"), 56] <-
  str_to_upper("Remorque à essieu central / Véhicule pompe à béton")
vehicles[which(vehicles$CODCAR == "DC17"), 56] <-
  str_to_upper("Remorque à essieu central / Transporteur de bois")
vehicles[which(vehicles$CODCAR == "DC20"), 56] <-
  str_to_upper("Remorque à essieu central / Compresseur")
vehicles[which(vehicles$CODCAR == "DC21"), 56] <-
  str_to_upper("Remorque à essieu central / Porte-bateau")
vehicles[which(vehicles$CODCAR == "DC22"), 56] <-
  str_to_upper("Remorque à essieu central / Porte-planeur")
vehicles[which(vehicles$CODCAR == "DC23"), 56] <-
  str_to_upper("Remorque à essieu central / Véhicules pour commerce ambulant ou exposition itinérante")
vehicles[which(vehicles$CODCAR == "DC29"), 56] <-
  str_to_upper("Remorque à essieu central / Remorque surbaissée")
vehicles[which(vehicles$CODCAR == "DC99"), 56] <-
  str_to_upper("Remorque à essieu central / Carrosserie non incluse sur la présente liste")
vehicles[which(vehicles$CODCAR == "DE02"), 56] <-
  str_to_upper("Remorque à timon d'attelage rigide / Ridelle rabattable")
vehicles[which(vehicles$CODCAR == "DE03"), 56] <-
  str_to_upper("Remorque à timon d'attelage rigide / Fourgon")

vehicles[which(vehicles$CODCAR == "SA"), 56] <-
  str_to_upper("Autocaravane")
vehicles[which(vehicles$CODCAR == "SB"), 56] <-
  str_to_upper("Véhicule blindé")
vehicles[which(vehicles$CODCAR == "SC"), 56] <-
  str_to_upper("Ambulance")
vehicles[which(vehicles$CODCAR == "SD"), 56] <-
  str_to_upper("Corbillard")
vehicles[which(vehicles$CODCAR == "SE"), 56] <-
  str_to_upper("Caravane")
vehicles[which(vehicles$CODCAR == "SF"), 56] <-
  str_to_upper("Grue mobile")
vehicles[which(vehicles$CODCAR == "SG"), 56] <-
  str_to_upper("Groupe spécial")
vehicles[which(vehicles$CODCAR == "SG18"), 56] <-
  str_to_upper("Groupe spécial / Benne à ordures ménagères")

vehicles$LIBCAR[which(vehicles$CODCAR == "ZZ")] <- NA
vehicles$LIBCAR.v2[which(vehicles$CODCAR == "ZZ")] <- NA

# Data cleansing of LIBCAR where CODCAR = "393C"
vehicles[which(vehicles$CODCAR == "393C"), c(56)] <-
  str_to_upper("EQUI. ELECT. / COMPRESSEUR")

CODCAR.LIBCAR <-
  arrange(summarize(group_by(vehicles, CODCAR, LIBCAR, LIBCAR.v2), Count = n()), CODCAR)

# Drop original LIBCAR
vehicles <- select(vehicles, -LIBCAR)

# Rename LIBCAR.v2 to LIBCAR
names(vehicles)[names(vehicles) == "LIBCAR.v2"] <- "LIBCAR"
label(vehicles$LIBCAR) <- "Bodywork wording"


# Frequency tables

FreqTable <- function(x) { 
    myDF <- as.data.frame(table(x, exclude = NULL)) 
    myDF$CumFreq <- cumsum( myDF$Freq ) 
    myDF$Prop <- round(100 * prop.table(myDF$Freq),2)
    myDF$CumProp <- cumsum( myDF$Prop ) 
    myDF 
  } 

# Method 1
CATEU1 <- FreqTable(vehicles.v2$CATEU)
CATEU1
View(CATEU1)

# Method 2
CATEU2 <- summarise(group_by(vehicles.v2, CATEU),Freq = n())
CATEU2$CumFreq <- cumsum(CATEU2$Freq)
CATEU2$Prop <- round(100 * prop.table(CATEU2$Freq),2)
CATEU2$CumProp <- cumsum(CATEU2$Prop)
CATEU2$CATEU <- as.vector(CATEU2$CATEU)
CATEU2$CATEU[which(CATEU2$Prop < 5)] <- "Other"

ggplot(data = CATEU2, aes(x=CATEU, y=Prop)) +
  geom_bar(stat="identity")

# Method 3
dplyr::count(vehicles.v2$CATEU)

# COUL
vehicles.v2$COUL[which(vehicles.v2$COUL == " ")] <- NA
COUL <- summarise(group_by(vehicles.v2, COUL),Freq = n())
COUL
View(COUL)

# INDUTI
INDUTI <- summarise(group_by(vehicles.v2, INDUTI),Freq = n())
View(INDUTI)

# PAYPVN
vehicles.v2$PAYPVN[which(vehicles.v2$PAYPVN == "")] <- NA
PAYPVN <- summarise(group_by(vehicles.v2, PAYPVN),Freq = n())
PAYPVN
View(PAYPVN)


# Reorder column
vehicles <-  vehicles[c(
  "CATSTC",
  "LIBSTC",
  "CODCAR",
  "LIBCAR",
  "CATEU",
  "COUL",
  "INDUTI",
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

# LIBCRB <-
#   as.data.frame(table(vehicles$LIBCRB), col.names = c("LIBCRB", "Freq"))
# View(LIBCRB)
# plot(LIBCRB)

