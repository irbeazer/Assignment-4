
# Libraries ---------------------------------------------------------------

library(shiny)
library(bslib)
library(tidyverse)

# load data
source('load_data.R')

# Define UI for application -----------------------------------------------
ui <- page_sidebar(
  
  title = 'NHANES Supplement Explorer',
  # navigation sidebar
  sidebar = sidebar(
    title = "Main Navigation",
    open = FALSE,
    collapsible = TRUE,
    
    navset_pill_list(
      id = "main_nav",
      
      nav_panel(
        "Overview",
        value = "home"
      ),
      
      nav_panel(
        "Data Exploration",
        value = "explore"
      ),
      
      nav_panel(
        "Learn",
        value = "learn"
      )
    )
  ),
  
  # main content
  navset_hidden(
    id = 'main_content',
    
    nav_panel(
      'Overview',
      value = 'home',
      h2('Overview')
    ),
    
    nav_panel(
      'data',
      value = 'explore',
      h2('Explore')
    ),
    
    nav_panel(
      'Learn',
      value = 'learn',
      h2('Learn')
    )
  )
)

# Define server logic -----------------------------------------------------
server <- function(input, output) {
  observe({
    nav_select(
      id = "main_content",
      selected = input$main_nav
    )
  })
  
}

# Run the application -----------------------------------------------------
shinyApp(ui = ui, server = server)

