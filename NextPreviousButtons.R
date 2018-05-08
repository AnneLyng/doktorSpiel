## Auhtor: Anne Lyngholm Sørensen
## Description: Reactive buttons

output$Next_Previous=renderUI({
  tab_list=input$List_of_tab[-length(input$List_of_tab)]
  nb_tab=length(tab_list)
  #if (which(tab_list==input$tabBox_next_previous)==nb_tab)
  #  column(1,offset=1,Previous_Button)
  #else if (which(tab_list==input$tabBox_next_previous)==1)
  #  column(1,offset = 10,Next_Button)
  #else
    div(column(1,offset=1,Previous_Button),column(1,offset=8,Next_Button))
  
})

observeEvent(input$Prev_Tab,
             {
               tab_list=input$List_of_tab
               current_tab=which(tab_list==input$tabBox_next_previous)
               updateTabsetPanel(session,"tabBox_next_previous",selected=tab_list[current_tab-1])
             }
)
observeEvent(input$Next_Tab,
             {
               tab_list=input$List_of_tab
               current_tab=which(tab_list==input$tabBox_next_previous)
               updateTabsetPanel(session,"tabBox_next_previous",selected=tab_list[current_tab+1])
             }
)