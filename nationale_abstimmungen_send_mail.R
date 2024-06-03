###GET CURRENT RESULTS ###
mydb <- connectDB(db_name="sda_votes")
rs <- dbSendQuery(mydb, "SELECT * FROM cantons_results")
cantons_results <- fetch(rs,n=-1)
dbDisconnectAll()

###GET OUTPUT OVERVIEW###
mydb <- connectDB(db_name="sda_votes")
rs <- dbSendQuery(mydb, "SELECT * FROM output_overview")
output_overview <- fetch(rs,n=-1)
dbDisconnectAll()

for (i in 1:nrow(output_overview)) {

canton_results <- cantons_results %>%
  filter(area_ID == )
  
    
}  