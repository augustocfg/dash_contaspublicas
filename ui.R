ui <- dashboardPage(
  dashboardHeader(title = "Contas Públicas"),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Início',
               tabName = 'homepage'),
      menuItem('RREO',
               tabName = 'rreo_part',
               menuSubItem('Receita E Despesa', 
                           tabName = 'rec_desp_rreo'))
      )
    ),
  dashboardBody(
    tabItems(
      tabItem(tabName = 'homepage'),
      tabItem(tabName = 'rec_desp_rreo',
              fluidRow(pickerInput('year1',
                                   choices = anos,
                                   label = 'Ano Inicial:',
                                   options = pickerOptions(style = list(color = 'white'))),
                       pickerInput('year2',
                                   choices = anos,
                                   label = 'Ano Final:', 
                                   selected = last(anos),
                                   options = pickerOptions(style = list(color = 'white'))),
                       pickerInput('bimester', 
                                   choices = 1:6,
                                   label = 'Semestre:',
                                   selected = 6,
                                   options = pickerOptions(style = list(color = 'white'))),
                       pickerInput('state', 
                                   choices = Estados$Código.da.UF,
                                   choicesOpt = list(subtext =Estados$Estado),
                                   multiple = T,
                                   options = pickerOptions(liveSearch = T,
                                                           style = list(color = 'white')),
                                   label = 'Estado:'),
                       actionButton('go_button',label = 'Iniciar')),
              fluidRow(radioButtons('despesa',
                                    label = 'Despesa:', inline = T,
                                    choices = c('Liquidadas', 'Empenhadas'))),
              box(title ='Receitas e Despesas Correntes',
                  echarts4rOutput('receitas_graph'))
    )
    )
  )
)
