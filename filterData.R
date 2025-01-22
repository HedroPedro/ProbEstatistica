library(dplyr)
library(readr)

filter_csv_BandaLarga <- function(csv_to_filter, banda_larga_csv, csv_name) {
  BandaLargaFx_XX_bruto <- read.csv(banda_larga_csv, sep=";", dec=',', encoding = "UTF-8")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",", encoding = "UTF-8")
  
  BandaLargaFx_XX_filtrado <- merge(BandaLargaFx_XX_bruto, Municipios, by = "Código.IBGE.Município")
  BandaLargaFx_XX_filtrado <- BandaLargaFx_XX_filtrado %>% select(-"Grupo.Econômico", -"Empresa", -"CNPJ", -"Porte.da.Prestadora", -"UF")
  write_excel_csv2(BandaLargaFx_XX_filtrado, file = csv_name, quote = "none")
} 

filter_csv_Telefonia <- function(csv_to_filter, telefonia_csv, csv_name) {
  Telefonia_XX_bruto <- read.csv(telefonia_csv, sep=";", dec=",", encoding = "UTF-8")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",", fileEncoding = "UTF-8")
  
  Telefonia_XX_filtrado <- merge(Telefonia_XX_bruto, Municipios, by = "Código.IBGE.Município")
  Telefonia_XX_filtrado <- Telefonia_XX_filtrado %>% select("Código.IBGE.Município", "Município", "Tecnologia.Geração", "Tipo.de.Pessoa", "Tipo.de.Produto", "Modalidade.de.Cobrança", "Acessos")
  write_excel_csv2(Telefonia_XX_filtrado, file = csv_name, quote = "none")
}

filter_csv_DensidadeMovel <- function(csv_to_filter, densidade_csv, csv_name) {
  Densidade_bruta <- read.csv(densidade_csv, sep=";", dec=",", encoding = "UTF-8")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",", encoding = "UTF-8")
  
  Densidade_filtrada <- merge(Municipios, Densidade_bruta, by = "Código.IBGE.Município")
  Acessos_filtrados <- Densidade_filtrada %>% select("Ano", "Mês", "Código.IBGE.Município", "Município", "Densidade") %>% filter("Ano" > 2021)
  write_excel_csv2(Acessos_filtrados, file = csv_name, quote = "none")
}

convert_spaces_to_dots <- function(table) {
  new_names <- c()
  for(col in colnames(table)) {
    append(new_names, gsub(" ", ".", col))
  }
  
  colnames(table) <- new_names
}

merge_csvs <- function(csv_1, csv_2, csv_name) {
  csv1 <- read.csv(csv_1, sep=";", dec=",", encoding = "UTF-8")
  csv2 <- read.csv(csv_2, sep=";", dec=",", encoding = "UTF-8")
  
  convert_spaces_to_dots(csv1)
  convert_spaces_to_dots(csv2)
  
  Merged_CSV <- merge(csv1, csv2)

  write_excel_csv2(Merged_CSV, file = csv_name, quote = "none")
}

setwd("C:\\Users\\pedro\\OneDrive\\Área de Trabalho\\ProbEstatistica")

csv_template_name <- "Amunorpi_Densidade_Telefonia_Movel.csv"
amunorpi <- "Dados_IBGE_Amunorpi_OK.csv"
top4AndCuritiba <- "Top4Amunorpi_Curitiba_IBGE_OK.csv"

filter_csv_DensidadeMovel(amunorpi, "Densidade_Telefonia_Movel.csv", csv_template_name)

csv_template_name <- "Top4Amunorpi_Curitiba_Densidade_Telefonia_Movel.csv"

filter_csv_DensidadeMovel(top4AndCuritiba, "Densidade_Telefonia_Movel.csv", csv_template_name)
