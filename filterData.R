library(dplyr)

filter_csv_BandaLarga <- function(csv_to_filter, banda_larga_csv, csv_name) {
  BandaLargaFx_XX_bruto <- read.csv(banda_larga_csv, sep=";", dec=',')
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",")
  
  BandaLargaFx_XX_filtrado <- merge(BandaLargaFx_XX_bruto, Municipios, by = "Código.IBGE.Município")
  BandaLargaFx_XX_filtrado <- BandaLargaFx_XX_filtrado %>% select(-"Grupo.Econômico", -"Empresa", -"CNPJ", -"Porte.da.Prestadora")
  write.csv(BandaLargaFx_XX_filtrado, file = csv_name, row.names=FALSE)
} 

filter_csv_Telefonia <- function(csv_to_filter, telefonia_csv, csv_name) {
  Telefonia_XX_bruto <- read.csv(telefonia_csv, sep=";", dec=",")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",")
  
  Telefonia_XX_filtrado <- merge(Telefonia_XX_bruto, Municipios, by = "Código.IBGE.Município")
  Telefonia_XX_filtrado <- Telefonia_XX_filtrado %>% select(-"Ano", -"Mês", -"Tecnologia.Geração", -"Tipo.de.Pessoa", -"Tipo.de.Produto", -"Modalidade.de.Cobrança", -"Acessos")
  write.csv(Telefonia_XX_filtrado, file = csv_name, row.names=FALSE)
}

filter_csv_Acessos <- function(csv_to_filter, acessos_csv, csv_name) {
  Acessos_bruto <- read.csv(acessos_csv, sep=";", dec=",")
  
  Municipios <- read.csv(csv_to_filter, sep=";", dec=",")
  Acessos_filtrados <- merge(Municipios, Acessos_bruto, by = "Código.IBGE.Município")
  Acessos_filtrados <- Acessos_filtrados %>% select(-"Ano", -"Mês", -"acessos", -"tipo")
  write.csv(Acessos_filtrados, file = csv_name, row.names=FALSE)
}

filter_csv_Acessos("Maiores_Municipios_Amunorpi_IBGE_OK.csv", "Velocidade_Contratada_SCM.csv", "top4_velocidade_contratada.csv")


