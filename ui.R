library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(leaflet)
library(collapsibleTree)
library(DT)
library(tigris)


shinyUI(
  fluidPage(
    ##################################
    # load page layout
    dashboardPage(
      
      skin = "blue",
      
      dashboardHeader(title="CEFIM DATA ANALYST", titleWidth = 300),
      
      
      dashboardSidebar(
                sidebarMenu(
                       HTML(paste0("<br>",
                                   #"<img src='CEFIM.png' width = '186'></img>",
                                   "<a href='' target='_blank'><img style = 'display: block; margin-left: auto; margin-right: auto;' src='CEFIM.png' width = '186'></a>",
                                   "<br>",
                                   #"<p style = 'text-align: center;'><small><a href='' target='_blank'>Logo cefim</a></small></p>",
                                    "<br>"
                              )),
                         #menuItem("Home", tabName = "home", icon = icon("home")),
                         menuItem("Etudiant", tabName = "Etudiant", icon = icon("thumbtack")),
                         menuItem("Promotion", tabName = "Promo", icon = icon("table")),
                         #menuItem("Species Tree", tabName = "tree", icon = icon("random", lib = "glyphicon")),
                         #menuItem("Species Charts", tabName = "charts", icon = icon("stats", lib = "glyphicon")),
                         #menuItem("Species Choropleth Map", tabName = "choropleth", icon = icon("map marked alt")),
                         #menuItem("Releases", tabName = "releases", icon = icon("tasks")),
                         
                         HTML(paste0(
                         "<br><br><br><br><br><br><br><br><br>",
                         "<table style='margin-left:auto; margin-right:auto;'>",

                         # "<tr>",
                         #   "<td style='padding: 5px;'><a href='https://www.facebook.com/nationalparkservice' target='_blank'><i class='fab fa-facebook-square fa-lg'></i></a></td>",
                         #   "<td style='padding: 5px;'><a href='https://www.youtube.com/nationalparkservice' target='_blank'><i class='fab fa-youtube fa-lg'></i></a></td>",
                         #   "<td style='padding: 5px;'><a href='https://www.twitter.com/natlparkservice' target='_blank'><i class='fab fa-twitter fa-lg'></i></a></td>",
                         #   "<td style='padding: 5px;'><a href='https://www.instagram.com/nationalparkservice' target='_blank'><i class='fab fa-instagram fa-lg'></i></a></td>",
                         #   "<td style='padding: 5px;'><a href='https://www.flickr.com/nationalparkservice' target='_blank'><i class='fab fa-flickr fa-lg'></i></a></td>",
                         #   "</tr>",
                           
                           "</table>",
                           "<br>"),
                           HTML(paste0(
                             "<script>",
                             "var today = new Date();",
                             "var yyyy = today.getFullYear();",
                             "</script>",
                             #"<p style = 'text-align: center;'><small>&copy; - <a href='https://alessiobenedetti.com' target='_blank'>alessiobenedetti.com</a> - <script>document.write(yyyy);</script></small></p>")
                             "<p style = 'text-align: center;'></p>")
                           )
                           )
                       )
                       
      ), # end dashboardSidebar
      
      dashboardBody(
    #############################
      tabItems(
          tabItem(tabName = "Etudiant",
                  fluidRow(
                    column(4,
                           selectInput("NomEtudiant",
                                       label="Nom :",
                                       choices = c("",data_etudiant$Nom))),
                    DT::dataTableOutput("table_etudiant")
                  )
                  ),
          tabItem(tabName = "Promo",
                  fluidRow(    #Code pour listes de roulant --> Promo
                           column(4,
                                    selectInput('promo',
                                                label = 'Promotion: ',
                                                choices = c("Promotion",data_promo$libelle),
                                                selectize=FALSE)),
                           column(4,selectInput('quest',label = 'Question: ',
                                                          choices = NULL)),
                           column(4,br(),
                                  actionButton("Btn_aff","Afficher")
                                  ),
                           box(
                             title = "Histogram",
                             background = "blue", 
                             solidHeader = TRUE,
                             plotOutput("plot1", height = 250),
                             collapsible=TRUE),
                           box(
                             title = "Barre", background = "yellow", 
                             solidHeader = TRUE,
                             plotOutput("plot2", height = 250),
                             collapsible=TRUE),
                           box(
                             title = "", background = "yellow",
                             solidHeader = TRUE,
                             selectInput("promo_f",
                                         "Promotion: ",
                                         c("Promotion",unique(as.character(data_texte$promo)))
                                        ),
                             DT::dataTableOutput("table_txt"),
                             collapsible=TRUE)
                           )
                  )
        )
      
 ################################################# 
    ) # end dashboardBody
  )# end dashboardPage
 #################################################
 
  )
 )

