cat("attach data set process\n")

cat("input network file path
ether from root directory or relative path form btool folder\n")
cat("Btool : attacher $")
userInput <- readLines(inputSource,1)
Gpath <- trimws(userInput)
if(!file.exists(Gpath)){
  cat("file not exist\n")
  stop("nope! it not exist")
}

cat("input file format 
support: edgelist pajek ncol lgl graphml dimacs graphdb gml dl\n")
while(T){
  cat("Btool : attacher $")
  userInput <- readLines(inputSource,1)
  Fmat<- trimws(userInput)
  if(Fmat%in%c("edgelist", "pajek", "ncol", "lgl", "graphml","dimacs", "graphdb", "gml", "dl")){
    break()
  }
  cat("invalid input\n")
}

cat("Graph info in put UU UW DU DW\n")
while(T){
  cat("Btool : attacher $")
  userInput <- readLines(inputSource,1)
  Ginf <- trimws(userInput)
  if(Ginf%in%c("UU","UW","DU","DW")){
    break()
  }
  cat("invalid input\n")
}

cat("input graph name\n")
cat("Btool : attacher $")
userInput <- readLines(inputSource,1)
Gname<- trimws(userInput)
Gname <- gsub(pattern = "_",replacement = "",x = Gname)

gr <- read.graph(file = Gpath,format = Fmat)
if(substr(Ginf,1,1)=="U"){
  gr <- simplify(gr)
}
last_graph_name
write.graph(graph = gr,file = paste("Data/dataset/R_",last_graph_name+1,"_",
                                    substr(Ginf,1,1),"_",substr(Ginf,2,2),"_",Gname,"_network.txt",sep = ""),format = "ncol")
last_graph_name <- last_graph_name+1

cat("input community file path\n")
cat("Btool : attacher $")
userInput <- readLines(inputSource,1)
Cpath <- trimws(userInput)
if(!file.exists(Cpath)){
  cat("file not exist\n")
  stop("nope! it not exist")
}
file.copy(from = Cpath,to = paste("Data/dataset/R_",last_graph_name,"_",
                                  substr(Ginf,1,1),"_",substr(Ginf,2,2),"_",Gname,"_community.txt",sep = "") )
cat("successfully attach",Gname,"\n")