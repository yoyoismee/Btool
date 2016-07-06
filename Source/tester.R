cat("Hi this is tester module\n")
all_name<-list.files("Data/dataset")
if(length(all_name)>0){
  n_name <- all_name[grepl(all_name,pattern = "network")]
  c_name <- all_name[grepl(all_name,pattern = "community")]
  s_name <- all_name[grepl(all_name,pattern = "statistic")]
  p_name <- all_name[grepl(all_name,pattern = "parameter")]
  
}
kpi_list<-read.csv("Metadata/kpilist.csv")
algorithm_list<-read.csv("Metadata/algorithmlist.csv")
if(length(n_name)>0){
  UU<-0
  DU<-0
  UW<-0
  DW<-0
  for(i in 1:length(n_name)){
    UU<-sum(UU,strsplit(n_name[i],"_")[[1]][3]=="U"&strsplit(n_name[i],"_")[[1]][4]=="U")
    UW<-sum(UW,strsplit(n_name[i],"_")[[1]][3]=="U"&strsplit(n_name[i],"_")[[1]][4]=="W")
    DU<-sum(DU,strsplit(n_name[i],"_")[[1]][3]=="D"&strsplit(n_name[i],"_")[[1]][4]=="U")
    DW<-sum(DW,strsplit(n_name[i],"_")[[1]][3]=="D"&strsplit(n_name[i],"_")[[1]][4]=="W")
  }
  cat("we have data of\n",UU,"undirected unweighted graph\n",UW,"weighted graph\n",DU,"directed graph\n",
      DW,"directed weighted graph\n")
  cat("specify target data set
aa for all
uu for undirected unweighted graph
uw for undirected weighted graph
du for directed unweighted graph
dw for directed weighted graph\n")
  graph_type<-0
  while(TRUE){
    cat("Btool : tester $")
    userInput <- readLines(inputSource,1)
    
    flag<-substr(trimws(userInput),1,2)
    if(flag=="aa"){
      graph_type<-0
      break()
    }else if(flag=="uu"){
      graph_type<-1
      break()
    }else if(flag=="uw"){
      graph_type<-2
      break()
    }else if(flag=="du"){
      graph_type<-3
      break()
    }else if(flag=="dw"){
      graph_type<-4
      break()
    }else{
      cat("invalid input\n")
    }
  }
  cat("select proportion of graph to test (0<proportion<=1)\n")
  while(T){
    cat("Btool : tester $")
    userInput <- readLines(inputSource,1)
    
    userInput<-as.numeric(userInput)
    if(!is.na(userInput)){
      if(userInput>0&userInput<=1){
        PP<-userInput
        break()
      }
    }
    cat("invalid input\n")
  }
  cat("which algorithm to test
-a for all 
-v for a list
-e for an expression\n")
  cat("algo list\n")
  for(i in 1:nrow(algorithm_list)){
    cat(i,toString(algorithm_list[i,]$algo_name),"\n")
  }

  while(T){
    cat("Btool : tester $")
    userInput <- readLines(inputSource,1)
    
    flag<-substr(trimws(userInput),1,2)
    if(flag == "-v"){
      userInput<-substr(trimws(userInput),3,99999)
      userInput<-trimws(userInput)
      if(length(strsplit(userInput,",")[[1]])>length(strsplit(userInput," ")[[1]])){
        userInput<-strsplit(userInput,",")[[1]]
        userInput<-as.numeric(userInput)
        if(!is.na(sum(userInput))&&length(userInput)>0){
          if(sum(userInput%in%1:nrow(algorithm_list))==length(userInput)){
            testing_algorithm<-userInput
            break()
          }
        }
      }else{
        userInput<-strsplit(userInput," ")[[1]]
        userInput<-as.numeric(userInput)
        if(!is.na(sum(userInput))&&length(userInput)>0){
          if(sum(userInput%in%1:nrow(algorithm_list))==length(userInput)){
            testing_algorithm<-userInput
            break()
          }
        }
      }
    }else if(flag == "-e"){
      userInput<-substr(trimws(userInput),3,99999)
      userInput<-trimws(userInput)
      userInput<-tryCatch(eval(parse(text=userInput)),error=function(e) NA)
      if(!is.na(sum(userInput))&&length(userInput)>0){
        if(sum(userInput%in%1:nrow(algorithm_list))==length(userInput)){
          testing_algorithm<-userInput
          break()
        }
      }
    }else if(flag == "-a"){
      testing_algorithm<- 1:nrow(algorithm_list)
      break()
    }
    cat("invalid input\n")
  }
  if(graph_type==0){
    ck1=c("U","D")
    ck2=c("U","W")
  }else if(graph_type==1){
    ck1=c("U")
    ck2=c("U")
  }else if(graph_type==2){
    ck1=c("U")
    ck2=c("W")
  }else if(graph_type==3){
    ck1=c("D")
    ck2=c("U")
  }else if(graph_type==4){
    ck1=c("D")
    ck2=c("W")
  }

  rm(testing_graph)
  for(i in 1:length(n_name)){
    if(strsplit(n_name[i],"_")[[1]][3]%in%ck1&strsplit(n_name[i],"_")[[1]][4]%in%ck2&sample(x = c(T,F),size = 1,prob = c(PP,1-PP))){
      if(exists("testing_graph")){
        testing_graph<-c(testing_graph,n_name[i])
      }else{
        testing_graph<-n_name[i]
      }
    }
  }
  if(!exists("testing_graph")){
    cat("have no graph to test that fit your condition\n")
    stop()
  }
  
  # graphID<-strsplit(testing_graph[1],"_")[[1]][5]
  # if(length(testing_graph)>1){
  #   for(i in 2:length(testing_graph)){
  #     graphID<-c(graphID,strsplit(testing_graph[i],"_")[[1]][5])
  #   }
  # }
  algorithm_name<- toString(algorithm_list[testing_algorithm[1],]$algo_name)
  if(length(testing_algorithm)>1){
    for(i in 2:length(testing_algorithm)){
      algorithm_name<- c(algorithm_name,toString(algorithm_list[testing_algorithm[i],]$algo_name))
    }
  }
  progress<-0
  for(gn in testing_graph){
    graphID<-strsplit(gn,"_")[[1]][5]
    result<-expand.grid(graphID,algorithm_name)
    names(result)<-c("graphID","algorithm_name")
    result$runtime<-NA
    result$directed<-NA
    result$weighted<-NA
    for(i in 1:nrow(kpi_list)){
      result[,toString(kpi_list[i,]$kpi_name)]<-NA
    }
    cat("\r",progress/length(testing_graph)*100," % (",progress,"out of",length(testing_graph),")")
    progress<-progress+1
    isDirec<-strsplit(gn,"_")[[1]][3]=="D"
    g<-read_graph(paste("Data/dataset/",gn,sep = ""),format = "ncol",directed = isDirec)
    if(!isDirec){
      g<-simplify(g)
    }
    GID<-strsplit(gn,"_")[[1]][5]
    result[result$graphID==GID,]$directed<-isDirec
    result[result$graphID==GID,]$weighted<-strsplit(gn,"_")[[1]][4]=="W"
    for(kp in 1:nrow(kpi_list)){
      if(kpi_list[kp,]$input_type==1){
        Kfun<-get(toString(kpi_list[kp,]$fun_name))
        Kname<-toString(kpi_list[kp,]$kpi_name)
        cat(Kname,"\n")
        result[result$graphID==GID,Kname]<-Kfun(g)
      }
    }
    if(file.exists(paste("Data/dataset/",sub(pattern = "network",replacement = "community",x = gn),sep = ""))){
      sol<-read.csv(file = paste("Data/dataset/",sub(pattern = "network",replacement = "community",x = gn),sep = ""),header = F,sep = "\t")
      names(sol)<-c("V","cl")
    }
    for(al in testing_algorithm){
      algo_fun<-get(toString(algorithm_list[al,]$fun_name))
      Aname<-toString(algorithm_list[al,]$algo_name)
      cat(Aname,"\n")
      if(isDirec&!algorithm_list[al,]$direc_compat){next()}
      if(length(V(g))>50&!algorithm_list[al,]$large_compat){next()}
      st<- Sys.time()
      cl<- tryCatch(algo_fun(g),error =function(e){NA})
      en<- Sys.time()
      rtime<- difftime(en,st,units = "secs")
      if(algorithm_list[al,]$outputType==1&!is.na(cl)){
        cl<-cl$membership
      }
      result[result$graphID==GID&result$algorithm_name==Aname,]$runtime <- rtime
      for(kp in 1:nrow(kpi_list)){
        if(kpi_list[kp,]$input_type==2){
          Kfun<-get(toString(kpi_list[kp,]$fun_name))
          Kname<-toString(kpi_list[kp,]$kpi_name)
          result[result$graphID==GID&result$algorithm_name==Aname,Kname]<- tryCatch(Kfun(g,cl),error=function(e){NA})
        }
      }
      for(kp in 1:nrow(kpi_list)){
        if(kpi_list[kp,]$input_type==3){
          Kfun<-get(toString(kpi_list[kp,]$fun_name))
          Kname<-toString(kpi_list[kp,]$kpi_name)
          result[result$graphID==GID&result$algorithm_name==Aname,Kname]<-tryCatch(Kfun(cl,sol$cl),error=function(e){NA})
        }
      }
    }
    write.table(result,file = "Test_Result.csv",row.names =F,col.names = !file.exists("Test_Result.csv"),append = T,sep = ",")
  }
  cat("you can see result in",WD,"file named Test_Result.csv\n")
}else{
cat("there is no data set to test\n
you can create net data set in gen graph option")
}
