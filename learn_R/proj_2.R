#------------------------------------------------------------------------
# Projeto 2
calagem <- function(v1, v2, ctc, prnt){
    
    n_calagem <- (v2 - v1) * (ctc/prnt)
    return(n_calagem)
}

x <- calagem(5.35, 3.5, 6.5, 0.15)
x
# input <- read.dcf("C:/Users/joaod/OneDrive/Documentos/UEPG - 3° ano/IC estatística/curso_R/learn_R/entradas.dcf")
# input
# 
# v1 <- as.numeric(input)
# v1
# 
# x <- calagem(v1)
# x
