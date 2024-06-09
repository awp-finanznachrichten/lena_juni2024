#repeat{
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

###Config: Bibliotheken laden, Pfade/Links definieren, bereits vorhandene Daten laden
source("CONFIG.R",encoding = "UTF-8")

#Simulate Data (if needed)
simulation <- FALSE
if (simulation == TRUE) {
source("./Simulation/data_simulation.R")  
}  

#SRG Hochrechnungen
source("SRG_API_Request.R", encoding = "UTF-8")

#Aktualisierungs-Check: Gibt es neue Daten?
mydb <- connectDB(db_name="sda_votes")
rs <- dbSendQuery(mydb, paste0("SELECT * FROM timestamps"))
timestamps <- DBI::fetch(rs,n=-1)
dbDisconnectAll()

timestamp_national <- timestamps$last_update[2]
timestamp_kantonal <- timestamps$last_update[1]
time_check_national <- timestamp_national == json_data$timestamp
time_check_kantonal <- timestamp_kantonal == json_data_kantone$timestamp

#time_check_national <- FALSE
#time_check_kantonal <- FALSE
if ((time_check_national == TRUE) & (time_check_kantonal == TRUE)) {
print("Keine neuen Daten gefunden")  
} else {
print("Neue Daten gefunden")
time_start <- Sys.time()

if (time_check_national == FALSE) {
###Write Data in DB###
source("nationale_abstimmungen_DB_entries.R", encoding = "UTF-8")

###Send Mail if Canton complete###
source("nationale_abstimmungen_send_mail.R", encoding = "UTF-8")
    
###Nationale Abstimmungen###
source("nationale_abstimmungen.R", encoding="UTF-8")

#Abstimmung komplett?
source("nationale_abstimmungen_report.R", encoding="UTF-8")

#Make Commit
source("commit.R", encoding="UTF-8") 
}

if (time_check_kantonal == FALSE) {  
###Kantonale Abstimmungen Uebersicht  
source("kantonale_abstimmungen_uebersicht.R", encoding="UTF-8")

###Kantonale Abstimmungen###
source("kantonale_abstimmungen.R", encoding="UTF-8")

###Kantonale Abstimmungen Sonderfälle###
source("kantonale_abstimmungen_special.R", encoding="UTF-8")

#Make Commit
source("commit.R", encoding="UTF-8")
}
  
if (time_check_national == FALSE) {
#Tabellen aktualisieren
source("votations_juin_2024/top_flop/top_flop_run.R", encoding="UTF-8")
}

#Timestamp speichern
mydb <- connectDB(db_name = "sda_votes")  
sql_qry <- paste0("UPDATE timestamps SET last_update = '",json_data$timestamp,"' WHERE data_type = 'results_national'")
rs <- dbSendQuery(mydb, sql_qry)
sql_qry <- paste0("UPDATE timestamps SET last_update = '",json_data_kantone$timestamp,"' WHERE data_type = 'results_cantonal'")
rs <- dbSendQuery(mydb, sql_qry)
dbDisconnectAll() 

#Wie lange hat LENA gebraucht
time_end <- Sys.time()
cat(time_end-time_start)
}

#Sys.sleep(10)
#}

