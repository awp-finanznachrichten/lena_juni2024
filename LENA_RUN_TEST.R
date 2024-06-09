MAIN_PATH <- "C:/Users/simon/OneDrive/LENA_Project/20240609_LENA_Abstimmungen"

#Working Directory definieren
setwd(MAIN_PATH)

###Funktionen laden
source("./Funktionen/functions_readin.R", encoding = "UTF-8")
source("./Funktionen/functions_storyfinder.R", encoding = "UTF-8")
source("./Funktionen/functions_storybuilder.R", encoding = "UTF-8")
source("./Funktionen/functions_output.R", encoding = "UTF-8")
source("./Funktionen/functions_github.R", encoding = "UTF-8")
source("./tools/Funktionen/Utils.R", encoding = "UTF-8")

repeat{
###Config: Bibliotheken laden, Pfade/Links definieren, bereits vorhandene Daten laden
source("CONFIG.R",encoding = "UTF-8")

#SRG Hochrechnungen
source("SRG_API_Request.R", encoding = "UTF-8")

###Write Data in DB###
source("nationale_abstimmungen_DB_entries.R", encoding = "UTF-8")

###Send Mail if Canton complete###
source("nationale_abstimmungen_send_mail.R", encoding = "UTF-8")
}  