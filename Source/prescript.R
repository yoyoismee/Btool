if(!require(igraph)){
  install.packages("igraph",repos="http://cran.rstudio.com/")
  require(igraph)
}
if(!require(random)){
  install.packages("random",repos="http://cran.rstudio.com/")
  require(random)
}
if(!require(parallel)){
  install.packages("parallel",repos="http://cran.rstudio.com/")
  require(parallel)
}
options(scipen = 100)
Argument<-commandArgs(trailingOnly = T)
if(length(Argument)==0){
  inputSource<- file("stdin")
}else{
  inputSource<- file(description = Argument,open = "r",blocking = T)
}

tmp<-list.files("Data/dataset")
last_graph_name<-0
if(length(tmp)>0){
  tmp<-strsplit(tmp,"_")
  for(i in 1:length(tmp)){
    if(last_graph_name<as.numeric(tmp[[i]][2]))
      last_graph_name<-as.numeric(tmp[[i]][2])
  }
}
tmp<-list.files("Data/kpi")
if(length(tmp)>0){
  for(i in tmp){
    source(paste("Data/kpi/",i,sep = ""))
    cat("sourced",i,"\n")
  }
}
tmp<-list.files("Data/algorithm")
if(length(tmp)>0){
  for(i in tmp){
    source(paste("Data/algorithm/",i,sep = ""))
    cat("sourced",i,"\n")
  }
}
cat("___________________________\n")