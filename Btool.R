WD <- getwd()
tryCatch(source(paste(WD,"/Source/prescript.R",sep = "")),error = function(e){cat("fatal error dution staring programm\n")})
cat("This is Btool, a utility tool for graph benchmarking
-g to gen graph
-t to testing
-i to insert new dataset, algorithm, or KPI
-q to exit program\n")
while(TRUE){
  cat("Btool : home $")
  userInput <- readLines(file("stdin"),1)
  flag<-substr(trimws(userInput),1,2)
  if(flag=="-q"){
    break()
  }else if(flag=="-t"){
    tryCatch(source(paste(WD,"/Source/tester.R",sep = "")),error = function(e){print(e);cat("fatal error in testing process\n")})
  }else if(flag=="-i"){
    tryCatch(source(paste(WD,"/Source/inserter.R",sep = "")),error = function(e){print(e);cat("fatal error in inserting process\n")})
  }else if(flag=="-g"){
    tryCatch(source(paste(WD,"/Source/genner.R",sep = "")),error = function(e){print(e);cat("fatal error in generating data set process\n")})
  }else{
    cat("Btool doesn't recognise this command\n")
  }
}
tryCatch(source(paste(WD,"/Source/posscript.R",sep = "")),error=function(e){cat("fatal error during ending process\n")})
cat("good bye
__________________________________________________
Phatrasek J.
yoyoismee@gmail.com\n")
