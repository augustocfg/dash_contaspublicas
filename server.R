server <- function(input, output,session) {
  
  siconfi_data <- reactiveValues(dados = NULL)
  
  
  observeEvent(input$go_button,{
    
    rsiconfi::get_rreo(c(input$year1:input$year2),input$bimester,1,"01",c(as.character(input$state))) ->> siconfi_data$dados
  })
  
  output$receitas_graph <- renderEcharts4r({
    siconfi_data$dados %>% 
      filter(str_detect(coluna, 'PREVISÃO INICIAL|\\(a\\)|\\(b\\)|\\(b/a\\)|\\(c\\)|\\(c/a\\)|\\(a - c\\)')) %>%  
      select(-conta) %>% 
      pivot_wider(names_from = 'coluna', values_from = 'valor',values_fill = 0) %>%  
      select(exercicio,uf,cod_conta,matches('Até')) %>% 
      filter(str_detect(cod_conta,'ReceitasExceto|IntraOrcamentariasTotal')) %>% 
      group_by(exercicio,uf) %>% 
      summarise(value = sum(`Até o Bimestre (c)`)) %>% 
      mutate(exercicio = as.factor(exercicio)) %>% 
      group_by(uf) %>% 
      e_charts(exercicio) %>% 
      e_line(value) %>%
      e_tooltip(trigger = 'axis',
                formatter = e_tooltip_pointer_formatter('currency',currency = 'BRL', locale = 'pt-br'))
    
  })
}