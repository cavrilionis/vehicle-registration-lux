
########## 04-clean.R ##########

# Get dataset
vehcln <- get(load(file.path("input", "vehcol.RData")))

# OPE is shown in the PDF but it is absent in the XSD and XML

# Padding zeros to CATSTC
typeof(vehcln$CATSTC)
vehcln$CATSTC.v2 <- sprintf("%02d", as.integer(vehcln$CATSTC))
typeof(vehcln$CATSTC.v2)
label(vehcln$CATSTC.v2) <- "Category Code Statec"
vehcln[1:5,c("CATSTC","CATSTC.v2")]

# Recoding CATSTC into LIBSTC
vehcln$LIBSTC <- car::recode(
  vehcln$CATSTC,
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

label(vehcln$LIBSTC) <- "Category Label Statec"

# Verify that CATSTC.v2 and LIBSTC are calculated correctly
arrange(summarize(group_by(vehcln, CATSTC, CATSTC.v2, LIBSTC), Count = n()), CATSTC.v2)

# Drop original CATSTC
vehcln <- select(vehcln, -CATSTC)

# Rename CATSTC.v2 to CATSTC
names(vehcln)[names(vehcln) == "CATSTC.v2"] <- "CATSTC"





# Some LIBCAR values are identical to CATSTC
# Set LIBCAR values where needed
typeof(vehcln$LIBCAR)
vehcln$LIBCAR.v2 <- vehcln$LIBCAR

vehcln[which(vehcln$CODCAR == "AA"), 56] <-
  str_to_upper("Berline")
vehcln[which(vehcln$CODCAR == "AB"), 56] <-
  str_to_upper("Voiture à hayon arrière")
vehcln[which(vehcln$CODCAR == "AC"), 56] <-
  str_to_upper("Break (familiale)")
vehcln[which(vehcln$CODCAR == "AD"), 56] <-
  str_to_upper("Coupé")
vehcln[which(vehcln$CODCAR == "AE"), 56] <-
  str_to_upper("Cabriolet")
vehcln[which(vehcln$CODCAR == "AF"), 56] <-
  str_to_upper("Véhicule à usages multiples")
vehcln[which(vehcln$CODCAR == "AG"), 56] <-
  str_to_upper("Break (commercial)")

vehcln[which(vehcln$CODCAR == "BA"), 56] <-
  str_to_upper("Camion")
vehcln[which(vehcln$CODCAR == "BB"), 56] <-
  str_to_upper("Camionnette")
vehcln[which(vehcln$CODCAR == "BC"), 56] <-
  str_to_upper("Unité de traction pour semi-remorque")
vehcln[which(vehcln$CODCAR == "BD"), 56] <-
  str_to_upper("Tracteur routier")
vehcln[which(vehcln$CODCAR == "BE"), 56] <-
  str_to_upper("Camion pick-up")
vehcln[which(vehcln$CODCAR == "BX"), 56] <-
  str_to_upper("Châssis-cabine ou châssis-capot")

vehcln[which(vehcln$CODCAR == "DA"), 56] <-
  str_to_upper("Semi-remorque")
vehcln[which(vehcln$CODCAR == "DB"), 56] <-
  str_to_upper("Remorque à timon d'attelage")
vehcln[which(vehcln$CODCAR == "DC"), 56] <-
  str_to_upper("Remorque à essieu central")
vehcln[which(vehcln$CODCAR == "DE"), 56] <-
  str_to_upper("Remorque à timon d'attelage rigide")

vehcln[which(vehcln$CODCAR == "BA01"), 56] <-
  str_to_upper("Camion / Plate-forme")
vehcln[which(vehcln$CODCAR == "BA02"), 56] <-
  str_to_upper("Camion / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "BA03"), 56] <-
  str_to_upper("Camion / Fourgon")
vehcln[which(vehcln$CODCAR == "BA04"), 56] <-
  str_to_upper(
    "Camion / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "BA06"), 56] <-
  str_to_upper("Camion / Bâchés")
vehcln[which(vehcln$CODCAR == "BA07"), 56] <-
  str_to_upper("Camion / Carrosserie amovible (superstructure interchangeable)")
vehcln[which(vehcln$CODCAR == "BA08"), 56] <-
  str_to_upper("Camion / Porte-conteneur")
vehcln[which(vehcln$CODCAR == "BA09"), 56] <-
  str_to_upper("Camion / Véhicules équipés d'une grue à crochet")
vehcln[which(vehcln$CODCAR == "BA10"), 56] <-
  str_to_upper("Camion / Benne basculante")
vehcln[which(vehcln$CODCAR == "BA11"), 56] <-
  str_to_upper("Camion / Citerne")
vehcln[which(vehcln$CODCAR == "BA12"), 56] <-
  str_to_upper("Camion / Citerne destinée au transport de marchandises dangereuses")
vehcln[which(vehcln$CODCAR == "BA13"), 56] <-
  str_to_upper("Camion / Bétaillère")
vehcln[which(vehcln$CODCAR == "BA14"), 56] <-
  str_to_upper("Camion / Transporteur de véhicules")
vehcln[which(vehcln$CODCAR == "BA17"), 56] <-
  str_to_upper("Camion / Transporteur de bois")
vehcln[which(vehcln$CODCAR == "BA19"), 56] <-
  str_to_upper("Camion / Balayeuse, véhicules de nettoyage et véhicules de curage de canalisations")
vehcln[which(vehcln$CODCAR == "BA24"), 56] <-
  str_to_upper("Camion / Dépanneuse")
vehcln[which(vehcln$CODCAR == "BA31"), 56] <-
  str_to_upper("Camion / Véhicules d'incendie")

vehcln[which(vehcln$CODCAR == "BB04"), 56] <-
  str_to_upper(
    "Camionnette / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "BB05"), 56] <-
  str_to_upper(
    "Camionnette / Carrosserie aménagée au moyen de cloisons isolées mais pas d'équipements pour maintenir la température intérieure"
  )

vehcln[which(vehcln$CODCAR == "CA"), 56] <-
  str_to_upper("Véhicule sans impériale")
vehcln[which(vehcln$CODCAR == "CB"), 56] <-
  str_to_upper("Véhicule à impériale")
vehcln[which(vehcln$CODCAR == "CE"), 56] <-
  str_to_upper("Véhicule surbaissé sans impériale")
vehcln[which(vehcln$CODCAR == "CG"), 56] <-
  str_to_upper("Véhicule articulé surbaissé sans impériale")
vehcln[which(vehcln$CODCAR == "CI"), 56] <-
  str_to_upper("Véhicule sans impériale à toit ouvert")
vehcln[which(vehcln$CODCAR == "CJ"), 56] <-
  str_to_upper("Véhicule à impériale à toit ouvert")

vehcln[which(vehcln$CODCAR == "DA01"), 56] <-
  str_to_upper("Semi-remorque / Plate-forme")
vehcln[which(vehcln$CODCAR == "DA02"), 56] <-
  str_to_upper("Semi-remorque / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "DA03"), 56] <-
  str_to_upper("Semi-remorque / Fourgon")
vehcln[which(vehcln$CODCAR == "DA04"), 56] <-
  str_to_upper(
    "Semi-remorque / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "DA05"), 56] <-
  str_to_upper(
    "Semi-remorque / Carrosserie aménagée au moyen de cloisons isolées mais pas d'équipements pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "DA06"), 56] <-
  str_to_upper("Semi-remorque / Bâchés")
vehcln[which(vehcln$CODCAR == "DA08"), 56] <-
  str_to_upper("Semi-remorque / Porte-conteneur")
vehcln[which(vehcln$CODCAR == "DA10"), 56] <-
  str_to_upper("Semi-remorque / Benne basculante")
vehcln[which(vehcln$CODCAR == "DA11"), 56] <-
  str_to_upper("Semi-remorque / Citerne")
vehcln[which(vehcln$CODCAR == "DA12"), 56] <-
  str_to_upper("Semi-remorque / Citerne destinée au transport de marchandises dangereuses")
vehcln[which(vehcln$CODCAR == "DA14"), 56] <-
  str_to_upper("Semi-remorque / Transporteur de véhicules")
vehcln[which(vehcln$CODCAR == "DA15"), 56] <-
  str_to_upper("Semi-remorque / Bétonneuse")
vehcln[which(vehcln$CODCAR == "DA16"), 56] <-
  str_to_upper("Semi-remorque / Véhicule pompe à béton")
vehcln[which(vehcln$CODCAR == "DA17"), 56] <-
  str_to_upper("Semi-remorque / Transporteur de bois")

vehcln[which(vehcln$CODCAR == "DA29"), 56] <-
  str_to_upper("Semi-remorque / Remorque surbaissée;")
vehcln[which(vehcln$CODCAR == "DA30"), 56] <-
  str_to_upper("Semi-remorque / Transporteur de vitrage")
vehcln[which(vehcln$CODCAR == "DA99"), 56] <-
  str_to_upper("Semi-remorque / Carrosserie non incluse sur la présente liste")

vehcln[which(vehcln$CODCAR == "DB01"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Plate-forme")
vehcln[which(vehcln$CODCAR == "DB02"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "DB03"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Fourgon")
vehcln[which(vehcln$CODCAR == "DB06"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Bâchés")
vehcln[which(vehcln$CODCAR == "DB07"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Carrosserie amovible (superstructure interchangeable)")
vehcln[which(vehcln$CODCAR == "DB08"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Porte-conteneur")
vehcln[which(vehcln$CODCAR == "DB12"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Citerne destinée au transport de marchandises dangereuses")
vehcln[which(vehcln$CODCAR == "DB14"), 56] <-
  str_to_upper("Remorque à timon d'attelage / Transporteur de véhicules")

vehcln[which(vehcln$CODCAR == "DC01"), 56] <-
  str_to_upper("Remorque à essieu central / Plate-forme")
vehcln[which(vehcln$CODCAR == "DC02"), 56] <-
  str_to_upper("Remorque à essieu central / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "DC03"), 56] <-
  str_to_upper("Remorque à essieu central / Fourgon")
vehcln[which(vehcln$CODCAR == "DC04"), 56] <-
  str_to_upper(
    "Remorque à essieu central / Carrosserie aménagée au moyen de cloisons isolées et d'équipements d'isolation pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "DC05"), 56] <-
  str_to_upper(
    "Remorque à essieu central / Carrosserie aménagée au moyen de cloisons isolées mais pas d'équipements pour maintenir la température intérieure"
  )
vehcln[which(vehcln$CODCAR == "DC06"), 56] <-
  str_to_upper("Remorque à essieu central / Bâchés")
vehcln[which(vehcln$CODCAR == "DC07"), 56] <-
  str_to_upper("Remorque à essieu central / Carrosserie amovible (superstructure interchangeable)")
vehcln[which(vehcln$CODCAR == "DC09"), 56] <-
  str_to_upper("Remorque à essieu central / Véhicules équipés d'une grue à crochet")
vehcln[which(vehcln$CODCAR == "DC10"), 56] <-
  str_to_upper("Remorque à essieu central / Benne basculante")
vehcln[which(vehcln$CODCAR == "DC13"), 56] <-
  str_to_upper("Remorque à essieu central / Bétaillère")
vehcln[which(vehcln$CODCAR == "DC14"), 56] <-
  str_to_upper("Remorque à essieu central / Transporteur de véhicules")
vehcln[which(vehcln$CODCAR == "DC16"), 56] <-
  str_to_upper("Remorque à essieu central / Véhicule pompe à béton")
vehcln[which(vehcln$CODCAR == "DC17"), 56] <-
  str_to_upper("Remorque à essieu central / Transporteur de bois")
vehcln[which(vehcln$CODCAR == "DC20"), 56] <-
  str_to_upper("Remorque à essieu central / Compresseur")
vehcln[which(vehcln$CODCAR == "DC21"), 56] <-
  str_to_upper("Remorque à essieu central / Porte-bateau")
vehcln[which(vehcln$CODCAR == "DC22"), 56] <-
  str_to_upper("Remorque à essieu central / Porte-planeur")
vehcln[which(vehcln$CODCAR == "DC23"), 56] <-
  str_to_upper("Remorque à essieu central / Véhicules pour commerce ambulant ou exposition itinérante")
vehcln[which(vehcln$CODCAR == "DC29"), 56] <-
  str_to_upper("Remorque à essieu central / Remorque surbaissée")
vehcln[which(vehcln$CODCAR == "DC99"), 56] <-
  str_to_upper("Remorque à essieu central / Carrosserie non incluse sur la présente liste")
vehcln[which(vehcln$CODCAR == "DE02"), 56] <-
  str_to_upper("Remorque à timon d'attelage rigide / Ridelle rabattable")
vehcln[which(vehcln$CODCAR == "DE03"), 56] <-
  str_to_upper("Remorque à timon d'attelage rigide / Fourgon")

vehcln[which(vehcln$CODCAR == "SA"), 56] <-
  str_to_upper("Autocaravane")
vehcln[which(vehcln$CODCAR == "SB"), 56] <-
  str_to_upper("Véhicule blindé")
vehcln[which(vehcln$CODCAR == "SC"), 56] <-
  str_to_upper("Ambulance")
vehcln[which(vehcln$CODCAR == "SD"), 56] <-
  str_to_upper("Corbillard")
vehcln[which(vehcln$CODCAR == "SE"), 56] <-
  str_to_upper("Caravane")
vehcln[which(vehcln$CODCAR == "SF"), 56] <-
  str_to_upper("Grue mobile")
vehcln[which(vehcln$CODCAR == "SG"), 56] <-
  str_to_upper("Groupe spécial")
vehcln[which(vehcln$CODCAR == "SG18"), 56] <-
  str_to_upper("Groupe spécial / Benne à ordures ménagères")

vehcln$LIBCAR[which(vehcln$CODCAR == "ZZ")] <- NA
vehcln$LIBCAR.v2[which(vehcln$CODCAR == "ZZ")] <- NA

# Data cleansing of LIBCAR where CODCAR = "393C"
vehcln[which(vehcln$CODCAR == "393C"), c(56)] <-
  str_to_upper("EQUI. ELECT. / COMPRESSEUR")

CODCAR.LIBCAR <-
  arrange(summarize(group_by(vehcln, CODCAR, LIBCAR, LIBCAR.v2), Count = n()), CODCAR)

# Drop original LIBCAR
vehcln <- select(vehcln, -LIBCAR)

# Rename LIBCAR.v2 to LIBCAR
names(vehcln)[names(vehcln) == "LIBCAR.v2"] <- "LIBCAR"
label(vehcln$LIBCAR) <- "Bodywork wording"

# Frequency tables

FreqTable <- function(x) {
  myDF <- as.data.frame(table(x, exclude = NULL))
  myDF$CumFreq <- cumsum(myDF$Freq)
  myDF$Prop <- round(100 * prop.table(myDF$Freq), 2)
  myDF$CumProp <- cumsum(myDF$Prop)
  myDF
}

# Method 1
CATEU1 <- FreqTable(vehcln$CATEU)
CATEU1
View(CATEU1)

# Method 2
CATEU2 <- summarise(group_by(vehcln, CATEU), Freq = n())
CATEU2$CumFreq <- cumsum(CATEU2$Freq)
CATEU2$Prop <- round(100 * prop.table(CATEU2$Freq), 2)
CATEU2$CumProp <- cumsum(CATEU2$Prop)
CATEU2$CATEU[which(CATEU2$Prop < 5)] <- "Other"

ggplot(data = CATEU2, aes(x = CATEU, y = Prop)) +
  geom_bar(stat = "identity")

ggsave(plot = last_plot(),
       path = "output",
       filename = "CATEU.png")

# Method 3
dplyr::count(vehcln$CATEU)

# COUL
vehcln$COUL[which(vehcln$COUL == " ")] <- NA
COUL <- summarise(group_by(vehcln, COUL), Freq = n())
COUL
View(COUL)

# INDUTI
INDUTI <- summarise(group_by(vehcln, INDUTI), Freq = n())
View(INDUTI)

# PAYPVN
vehcln$PAYPVN[which(vehcln$PAYPVN == "")] <- NA
PAYPVN <- summarise(group_by(vehcln, PAYPVN), Freq = n())
PAYPVN
View(PAYPVN)

# Reorder columns
vehcln <-  vehcln[c(
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
#   as.data.frame(table(vehcln$LIBCRB), col.names = c("LIBCRB", "Freq"))
# View(LIBCRB)
# plot(LIBCRB)

# Save dataset
save(vehcln, file = file.path("input", "vehcln.RData"))
