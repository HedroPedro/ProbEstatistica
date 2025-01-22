library(dplyr)
library(readr)

filter_csv_BandaLarga <- function(csv_to_filter, banda_larga_csv, csv_name) {
  BandaLargaFx_XX_bruto <- read.csv(banda_larga_csv, sep=";", dec=',', encoding = "UTF-8")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",", encoding = "UTF-8")
  
  BandaLargaFx_XX_filtrado <- merge(BandaLargaFx_XX_bruto, Municipios, by = "Código.IBGE.Município")
  BandaLargaFx_XX_filtrado <- BandaLargaFx_XX_filtrado %>% select(-"Grupo.Econômico", -"Empresa", -"CNPJ", -"Porte.da.Prestadora")
  write_excel_csv2(BandaLargaFx_XX_filtrado, file = csv_name, quote = "none")
} 

filter_csv_Telefonia <- function(csv_to_filter, telefonia_csv, csv_name) {
  Telefonia_XX_bruto <- read.csv(telefonia_csv, sep=";", dec=",", encoding = "UTF-8")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",", fileEncoding = "UTF-8")
  
  Telefonia_XX_filtrado <- merge(Telefonia_XX_bruto, Municipios, by = "Código.IBGE.Município")
  Telefonia_XX_filtrado <- Telefonia_XX_filtrado %>% select("Código.IBGE.Município", "Município", "Tecnologia.Geração", "Tipo.de.Pessoa", "Tipo.de.Produto", "Modalidade.de.Cobrança", "Acessos")
  write_excel_csv2(Telefonia_XX_filtrado, file = csv_name, quote = "none")
}

filter_csv_Velocidade <- function(csv_to_filter, acessos_csv, csv_name) {
  Acessos_bruto <- read.csv(acessos_csv, sep=";", dec=",", encoding = "UTF-8")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",", encoding = "UTF-8")
  
  Acessos_filtrados <- merge(Municipios, Acessos_bruto, by = "Código.IBGE.Município")
  Acessos_filtrados <- Acessos_filtrados %>% select(-"Ano", -"acessos", -"tipo")
  write_excel_csv2(Acessos_filtrados, file = csv_name, quote = "none")
}

merge_csvs <- function(csv_1, csv_2, csv_name) {
  csv1 <- read.csv(csv_1, sep=";", dec=",", encoding = "UTF-8")
  csv2 <- read.csv(csv_2, sep=";", dec=",", encoding = "UTF-8")
  
  Merged_CSV <- merge(csv1, csv2)

  write_excel_csv2(Merged_CSV, file = csv_name, quote = "none")
}

setwd("C:\\Users\\pedro\\OneDrive\\Área de Trabalho\\ProbEstatistica")

csv_template_name <- "Amunorpi_Acessos_Telefonia_Movel_202"
amunorpi <- "Dados_IBGE_Amunorpi_OK.csv"
top4AndCuritiba <- "Top4Amunorpi_Curitiba_IBGE_OK.csv"

for(ano in 2:4) {
  telefonia_csv <- paste("Acessos_Telefonia_Movel_202",ano,".csv", sep="")
  csv_name <- paste(csv_template_name, ano, ".csv", sep="")
  filter_csv_Telefonia(amunorpi, telefonia_csv, csv_name)
}

csv_template_name <- "Top4Amunorpi_Curitiba_Acessos_Telefonia_Movel_202"

for(ano in 2:4) {
  telefonia_csv <- paste("Acessos_Telefonia_Movel_202",ano,".csv", sep="")
  csv_name <- paste(csv_template_name, ano, ".csv", sep="")
  filter_csv_Telefonia(amunorpi, telefonia_csv, csv_name)
}