cat(">>>>>enter graph generating process<<<<<\n")
cat("select the generator\n")
gennerlist<-read.csv(paste(WD,"/Metadata/gennerlist.csv",sep = ""))
for(i in 1:nrow(gennerlist))
  cat(i," for ",toString(gennerlist[i,]$algo)," ",toString(gennerlist[i,]$info),"\n")
while(T){
  cat("Btool : generator module $")
  userInput <- readLines(file("stdin"),1)
  userInput<-as.integer(userInput)
  if(!is.na(userInput))
    if(userInput>0)
      if(!is.na(gennerlist[userInput,]$Fname)){
        cat("selected ",toString(gennerlist[userInput,]$algo),"\n")
        sgn<-gennerlist[userInput,]
      break()
      }
    cat("invalid input\n")
}
p1<- paste(".","/Data/generator/",sgn$Fname,sep = "")
needed<-strsplit(toString(sgn$needed),"-")[[1]]
optional<-strsplit(toString(sgn$option),"-")[[1]]
cat("input argument that must be specified
the graph generator programm you choosed
require this parameter so you need specified it
there are 2 input mode -v and -e
___________________________________________
-v for a vector input 
e.g. -v 1,1.5,2,2.5,3 or -v 1 1.5 2 2.5 3 (can't mix)
one space only if you use space
no space if you use ,
___________________________________________
-e for an expression input 
e.g. -e seq(1,3,0.5) or -e 1:3 or any r expression
>>>>>>>> Caution!! <<<<<<<<
the input are used directly (not sanitized)
if it result in error in R
this program will crash
and any attemp to attack the program
such as deleting file, drop table ,etc......will work 
take care
Pj 
___________________________________________
note: 
-v will use anything come after it go gen the graph 
while -e will use result from evaluating the input to do so\n")
for(i in 1:length(needed)){
  cat("input ",needed[i],"\n")
  while(T){
    cat("Btool : generator module $")
    userInput <- readLines(file("stdin"),1)
    flag<-substr(trimws(userInput),1,2)
    if(flag == "-v"){
      userInput<-substr(trimws(userInput),3,99999)
      userInput<-trimws(userInput)
      if(length(strsplit(userInput,",")[[1]])>length(strsplit(userInput," ")[[1]])){
        userInput<-strsplit(userInput,",")[[1]]
        userInput<-as.numeric(userInput)
        if(!is.na(sum(userInput))&&length(userInput)>0){
          break()
        }
      }else{
        userInput<-strsplit(userInput," ")[[1]]
        userInput<-as.numeric(userInput)
        if(!is.na(sum(userInput))&&length(userInput)>0){
          break()
        }
      }
    }else if(flag == "-e"){
      userInput<-substr(trimws(userInput),3,99999)
      userInput<-trimws(userInput)
      userInput<-tryCatch(eval(parse(text=userInput)),error=function(e) NA)
      if(!is.na(sum(userInput))&&length(userInput)>0){
        break()
      }
    }
    cat("invalid input\n")
  }
  fg<-paste("-",needed[i],sep = "")
  pmt<-paste(fg,userInput)
  buf<-trimws(paste(p1[1],pmt[1]))
  for(ft in 1:length(p1))
    for(bk in 1:length(pmt)){
      buf<-c(buf,trimws(paste(p1[ft],pmt[bk])))
    }
  p1<-buf
  p1<-unique(p1)
  cat("total graph count = ",length(p1),"\n")
}
cat("\nyou can also specified some optional argument listed below\n")
for(x in 1:length(optional)){
cat(paste("-",optional[x],sep = ""),"\n")
}
cat("input parameter name to specified or -99 if to continue\n")
while(T){
  cat("Btool : generator module $")
  userInput <- readLines(file("stdin"),1)
  flag<-substr(trimws(userInput),1,3)
  if(flag == "-99"){
    break()
  }else if(trimws(substr(trimws(userInput),2,999))%in%optional){
    opP<-trimws(substr(trimws(userInput),1,999))
    cat("input",opP,"\n")
      while(T){
        cat("Btool : generator module $")
        userInput <- readLines(file("stdin"),1)
        flag<-substr(trimws(userInput),1,2)
        if(flag == "-v"){
          userInput<-substr(trimws(userInput),3,99999)
          userInput<-trimws(userInput)
          if(length(strsplit(userInput,",")[[1]])>length(strsplit(userInput," ")[[1]])){
            userInput<-strsplit(userInput,",")[[1]]
            userInput<-as.numeric(userInput)
            if(!is.na(sum(userInput))&&length(userInput)>0){
              break()
            }
          }else{
            userInput<-strsplit(userInput," ")[[1]]
            userInput<-as.numeric(userInput)
            if(!is.na(sum(userInput))&&length(userInput)>0){
              break()
            }
          }
        }else if(flag == "-e"){
          userInput<-substr(trimws(userInput),3,99999)
          userInput<-trimws(userInput)
          userInput<-eval(parse(text=userInput))
          if(!is.na(sum(userInput))&&length(userInput)>0){
            break()
          }
        }
        cat("invalid input\n")
      }
      fg<-opP
      pmt<-paste(fg,userInput)
      buf<-trimws(paste(p1[1],pmt[1]))
      for(ft in 1:length(p1))
        for(bk in 1:length(pmt)){
          buf<-c(buf,trimws(paste(p1[ft],pmt[bk])))
        }
      p1<-buf
      p1<-unique(p1)
      cat("total graph count = ",length(p1),"\n")
  }else{
    cat("that parameter not exist\n")
  }
}
cat("specified number so graph per setting\n")
while(T){
  cat("Btool : generator module $")
  userInput <- readLines(file("stdin"),1)
  userInput<-as.integer(userInput)
  if(!is.na(userInput)){
    if(userInput>0){
      Ng<-userInput
      break()
    }
  }
  cat("invalid input\n")
}
error<-0
curr<-strsplit(gsub(":","-",toString(Sys.time()))," ")[[1]]
for(i in 1:length(p1)){
  for (j in 1:Ng){
    cat("\r",round(((i-1)*Ng+j)/(Ng*length(p1))*10000)/100," % (",((i-1)*Ng+j),"out of", (Ng*length(p1)),")")
    cat(p1[i],"\n")
    tryCatch(system(p1[i],ignore.stdout=T),error=function(e){cat("error in external programm\n")})
    if(file.exists(toString(sgn$Nname))){
      gname<-paste("G_",last_graph_name+1,"_",sgn$graph_spec,"_",randomStrings(n=1,len = 10),sep="")
      if(file.exists(toString(sgn$Sname))){
        file.rename(toString(sgn$Sname),paste("Data/dataset/",gname,"_statistics.txt",sep = ""))
      }
      if(file.exists(toString(sgn$Nname))){
        file.rename(toString(sgn$Nname),paste("Data/dataset/",gname,"_network.txt",sep = ""))
      }
      if(file.exists(toString(sgn$Cname))){
        file.rename(toString(sgn$Cname),paste("Data/dataset/",gname,"_community.txt",sep = ""))
      }
      write(paste(toString(sgn$algo),substr(p1[i],regexpr('-',p1[i])[1],9999)),paste("Data/dataset/",gname,"_parameter.txt",sep = ""))
      last_graph_name <- last_graph_name + 1
    }else{
      error<-error+1
    }
  }
}
cat("\n\n_____________________\ncomplete with ",error," errors
you can find data in",paste(WD,"/Data/dataset/\n",sep=""))