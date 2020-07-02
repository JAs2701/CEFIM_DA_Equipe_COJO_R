library(RMySQL)
library(tidyverse)

conn_db <- dbConnect(MySQL(), user="root", password="Qo!27_Tm0#", 
                     host="127.0.0.1", 
                     dbname="evaluation")

dbGetQuery(conn_db,"SET NAMES 'utf8'")

data_etudiant <- conn_db %>% 
  tbl("v_etudiant") %>% 
  collect()

data_info_etudiant <- conn_db %>% 
  tbl("v_info_etudiant") %>% 
  collect()

data_info_etudiant

data_promo <- conn_db %>% 
  tbl("CHOIX") %>% 
  filter(question_id == 14) %>% 
  collect()

data_question <- conn_db %>% 
  tbl("v_question") %>% 
  collect()

data_reponse <- conn_db %>% 
  tbl("reponse") %>% 
  collect()

data_q <- conn_db %>% 
  tbl("question") %>% 
  collect()

data <- inner_join(data_reponse,data_q,by = ("question_id" = "id")) %>% 
  inner_join(data_promo,by = ("choix_id" = "id"),suffix = c("_master","_promo")) %>% 
  select(question_id,libelle_master,texte,date,score,libelle_promo)

data_gral <- inner_join(data_reponse,data_question, by = c("question_id"="id")) %>% 
  select(promo,question,type,texte,date,score)



dbDisconnect(conn_db)
