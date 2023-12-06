library(magick)
library(tidyverse)
arquivos <- list.files("C:/Users/FLeal/OneDrive - COMPANHIA AIX DE PARTICIPACOES/Área de Trabalho/G188/tamanho_original", full.names = TRUE) |>
  as_tibble_col("caminho") |>
  mutate(arquivo = list.files("C:/Users/FLeal/OneDrive - COMPANHIA AIX DE PARTICIPACOES/Área de Trabalho/G188/tamanho_original", full.names = FALSE)) |>
  mutate(arquivo =sub("\\.[^.]*$", "", arquivo)) |>
  mutate(novocaminho = gsub("(.*)(/[^/]*)/[^/]*$", "\\1", caminho)) |>
  mutate(novocaminho = paste0(novocaminho,"/", arquivo)) |>
  select(-arquivo)


reduzir_imagens <- function(caminho, novocaminho, tamanho = "1080x", formato = "jpeg"){

  img <- image_read(caminho)
  img_resized <- image_scale(img, tamanho)
  image_write(img_resized, path = paste0(novocaminho,".",formato), format = formato)
}

pmap(arquivos, reduzir_imagens)

blogdown::build_site()
blogdown::serve_site()

# Localizar arquivos ------------------------------------------------------

# FGLUtils::find_files(pattern = "188", )
