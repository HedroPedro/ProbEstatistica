library(dplyr)
library(readr)

filter_csv_BandaLarga <- function(csv_to_filter, banda_larga_csv, csv_name) {
  BandaLargaFx_XX_bruto <- read.csv(banda_larga_csv, sep=";", dec=',', encoding = "UTF-8")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",", encoding = "UTF-8")
  
  BandaLargaFx_XX_filtrado <- merge(BandaLargaFx_XX_bruto, Municipios, by = "Código.IBGE.Município")
  BandaLargaFx_XX_filtrado <- BandaLargaFx_XX_filtrado %>% select(-"Grupo.Econômico", -"Empresa", -"CNPJ", -"Porte.da.Prestadora")
  write_excel_csv(BandaLargaFx_XX_filtrado, file = csv_name)
} 

filter_csv_Telefonia <- function(csv_to_filter, telefonia_csv, csv_name) {
  Telefonia_XX_bruto <- read.csv(telefonia_csv, sep=";", dec=",", encoding = "UTF-8")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",", fileEncoding = "UTF-8")
  
  Telefonia_XX_filtrado <- merge(Telefonia_XX_bruto, Municipios, by = "Código.IBGE.Município")
  Telefonia_XX_filtrado <- Telefonia_XX_filtrado %>% select(-"Ano", -"Mês", -"Tecnologia.Geração", -"Tipo.de.Pessoa", -"Tipo.de.Produto", -"Modalidade.de.Cobrança", -"Acessos")
  write_excel_csv(Telefonia_XX_filtrado, file = csv_name)
}

filter_csv_Velocidade <- function(csv_to_filter, acessos_csv, csv_name) {
  Acessos_bruto <- read.csv(acessos_csv, sep=";", dec=",", encoding = "UTF-8")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",", encoding = "UTF-8")
  Acessos_filtrados <- merge(Municipios, Acessos_bruto, by = "Código.IBGE.Município")
  Acessos_filtrados <- Acessos_filtrados %>% select(-"Ano", -"Mês", -"acessos", -"tipo")
  write_excel_csv(Acessos_filtrados, file = csv_name)
}


for(ano in 2:4) {
  banda_larga <- paste(ano-1, "_Acessos_Banda_Larga_Fixa_202",ano,".csv", sep = "")
  csv_name <- paste("Top4Amunorpi_Curitiba_Banda_Larga_Fixa_202", ano, ".csv", sep = "")
  filter_csv_BandaLarga("Top4Amunorpi_Curitiba_IBGE_OK.csv", banda_larga, csv_name)
}

