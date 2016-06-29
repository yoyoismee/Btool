if(!require(igraph)){
  install.packages("igraph")
  require(igraph)
}
if(!require(random)){
  install.packages("random")
  require(random)
}
tmp<-list.files("data/dataset")
last_graph_name<-0
if(length(tmp)>0){
  tmp<-strsplit(tmp,"_")
  for(i in 1:length(tmp)){
    if(last_graph_name<as.numeric(tmp[[i]][2]))
      last_graph_name<-as.numeric(tmp[[i]][2])
  }
}
tmp<-list.files("data/kpi")
if(length(tmp)>0){
  for(i in tmp){
    source(paste("data/kpi/",i,sep = ""))
    cat("sourced",i,"\n")
  }
}
tmp<-list.files("data/algorithm")
if(length(tmp)>0){
  for(i in tmp){
    source(paste("data/algorithm/",i,sep = ""))
    cat("sourced",i,"\n")
  }
}
cat("___________________________\n")