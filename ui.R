ui <- dashboardPage(
  dashboardHeader(title = "Contas Públicas"),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Início',
               tabName = 'homepage'),
      menuItem('Dashboard',
               tabName = 'development')
      )
    ),
  dashboardBody(
    tabItems(
      tabItem(tabName = 'homepage'),
      tabItem(tabName = 'development',
              fluidRow(selectInput('year1',
                                   choices = anos,
                                   label = 'Ano Inicial:'),
                       selectInput('year2',
                                   choices = anos,
                                   label = 'Ano Final:', 
                                   selected = last(anos)),
                       selectInput('bimester', 
                                   choices = 1:6,
                                   label = 'Semestre:'),
                       selectInput('anex', 
                                   choices = c(as.character(1:14)),
                                   label = 'Anexo:'),
                       selectInput('state', 
                                   choices = c(1:24)),
                                   label = 'Estado:')),
              box(title ='Receitas e Despesas Correntes')
    )
    )
  )
)
