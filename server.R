library(shiny)
library(shinyjs)
library(pivottabler)


#install.packages("pivottabler")

shinyServer(
  function(input,output, session)
    {
    
    ## Etudiant
    #reactive({get(input$NomEtudiant)})
    
    #### Promo
    reactive({get(input$promo)})
    
    output$table_etudiant <- DT::renderDataTable({
      
      info_session <- data_reponse %>%
        filter(question_id == 2 & texte == input$NomEtudiant) %>% 
        pull(session_id)

      if(length(info_session) == 0)
      {
        return()
      }
      
      text <- data_info_etudiant %>%
        filter(session_id == info_session) %>% 
        select(promotion,question,commentaire,score)
      
      
      text
      
    })
    
    observe({
      
      if(input$promo == "Promotion")
      {
        updateSelectInput(session,"",label = "Question:",
                          choices = NULL)
        data_score <- data_gral %>% 
          filter(type == "score" & !is.na(score)) 
        
        data_texte <- data_gral %>% 
          filter(type != "score") %>% 
          select(promo,texte)
        
        output$plot1 <- renderPlot({
          ggplot(data_score,aes(x = score)) +
            geom_histogram(fill="skyblue", alpha=0.5)})
        
        
        output$plot2 <- renderPlot({
          ggplot(data_score,aes(x = score)) +
            geom_bar(aes(fill = promo),)})
        
        output$table_txt <- DT::renderDataTable(
          DT::datatable({
            data <- data_texte
            if(input$promo_f != "Promotion")
            {
             data <- data[data$promo == input$promo_f,] 
            }
            data
          }))
        
      }
      else
      {
        updateSelectInput(session,"quest",label = "Question:",
                          choices = c("Question",data_question %>% 
                                        filter(promo == input$promo) %>% 
                                        select(question)))
      }
    })# fin observe
    
    
    #### Btn
    
    observeEvent(input$Btn_aff,{
      #Question
      reactive({get(input$quest)})
      
      if(input$quest != "Question" | is.na(input$quest))
      {
        type_question <- data_gral %>% 
            filter(promo == input$promo & question == input$quest ) %>% 
            pull(type)
       
        if(length(type_question) == 0)
        {return()}
        else if (type_question == "score")
        {
          g_score <- data_gral %>%
            filter(promo == input$promo & question == input$quest)
          
          output$plot1 <- renderPlot({
            ggplot(g_score,aes(x = score)) +
              geom_histogram(fill="skyblue", alpha=0.5)})
          
          
          output$plot2 <- renderPlot({
            ggplot(g_score,aes(x = score)) +
              geom_bar(aes(fill = promo))})
        }
        else
        {
          data_texte <- data_gral %>% 
            filter(promo == input$promo & question == input$quest) %>% 
            select(texte)
          
          #box(input$Histo,)
          
          
          output$table_txt <- DT::renderDataTable(
                 DT::datatable({
                   data <- data_texte
                   if(input$promo_f != "Promotion")
                   {
                     data <- data[data$promo == input$promo_f,] 
                   }
                   data
                 }))     
               
          
        }
      }
      else
      {
        datapromo_score <- data_gral %>% 
          filter(promo == input$promo & type == "score")
          
        
        output$plot1 <- renderPlot({
          ggplot(datapromo_score,aes(x = score)) +
            geom_histogram(fill="skyblue", alpha=0.5)})
        
        
        output$plot2 <- renderPlot({
          ggplot(datapromo_score,aes(x = score)) +
            geom_bar(aes(fill = promo))})
        
        datapromo_txt <- data_gral %>% 
          filter(promo == input$promo & type != "score") %>% 
          select(texte)
        
        output$table_txt <- DT::renderDataTable(
          datapromo_txt)
      }
    })
    
   
      
    
    
    
    
    })