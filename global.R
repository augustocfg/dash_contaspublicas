library(bs4Dash)
library(shiny)
library(dplyr)
library(rsiconfi)
library(echarts4r)
library(lubridate)
library(tidyr)
library(shinyWidgets)

read.csv('estados.csv') %>% 
  select(-X) -> Estados

c(2015:year(Sys.Date()-60)) -> anos


rsiconfi::get_rreo(2020,6,1,"01",'24') %>%  View()

teste %>% 
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
