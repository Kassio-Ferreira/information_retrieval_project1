# MUDAR O TOTAL QUANDO FOR RODAR DE NOVO

library(dplyr)
library(xml2)
library(rvest)
library(purrr)

#content = "https://arxiv.org/list/stat/new"
#content = readLines(content)
#content

titulo <- read_html("https://arxiv.org/list/stat/new") %>% html_nodes(xpath = '//*[@class="list-title mathjax"]') 
texto <- read_html("https://arxiv.org/list/stat/new") %>% html_nodes(xpath = '//*[@class="mathjax"]') 
doc_titulo = xml2::as_list(titulo)
doc_resumo = xml2::as_list(texto)


setwd("/home/kassio/Dropbox/MestradoCin/Recuperacao_inteligente_de_informacao/tarefa1/corpus")

cont = 21
total = 18

for(i in 1:total){
  
  nome = paste0("doc", "_", cont, ".txt")
  write(paste0("Title: ", doc_titulo[[i]][[3]]), file=nome, append = FALSE)
  
  for(j in 1:6){
    caminho = paste0('//*[@id="dlpage"]/dl[1]/dd[',i,']/div/div[2]/a[',j,']')
    autores <- read_html("https://arxiv.org/list/stat/new") %>% html_nodes(xpath = caminho)
    doc_autor = xml2::as_list(autores)
    tryCatch(write(paste0("Author: ",doc_autor[[1]][[1]]), file=nome, append = TRUE), error=function(e) {})
  }
  
  write(paste0("Abstract: ", doc_resumo[[i]][[1]]), file=nome, append = TRUE)
  cont = cont+1
  
}

