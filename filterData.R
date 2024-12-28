filter_csv <- function(path, amunorpi = "0_Municipios_Amunorpi_e_Dados_IBGE.csv", second, csv_Name = "csv.csv") {
  library(dplyr)
  
  setwd(path)
  
  BandaLargaFx_XX_Bruto <-  read.csv(second, sep=";", dec=",")
  
  Municipios_Amunorpi <- read.csv(amunorpi, sep=";", dec=",")
  
  BandaLargaFx_XX_filtrado<- merge (BandaLargaFx_XX_Bruto, Municipios_Amunorpi, by = "Código.IBGE.Município")
  
  BandaLargaFx_XX_filtrado <- BandaLargaFx_XX_filtrado %>% select(-"Grupo.Econômico", - "Empresa", -"CNPJ", -"Porte.da.Prestadora", -"X1", -"X1.1", -"Municípios.da.Amunorpi")
  
  write.csv(BandaLargaFx_XX_filtrado, file = csv_Name, row.names=FALSE, fileEncoding = "UTF-8")

}

