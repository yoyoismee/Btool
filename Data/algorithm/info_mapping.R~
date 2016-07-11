cluster_infomapping <- function(file){
    # Executing external program Infomap to calculate cluster
    infomapping <- paste("./Data/algorithm/exe/Infomap --clu ","./Data/dataset/",file," .",sep = "")
    tryCatch(system(infomapping,ignore.stdout=T),error=function(e){cat("Error in executing external program\n")})
    if(file.exists(list.files(path = "./", pattern = "network.clu"))){
        sol<-read.csv(list.files(path = "./", pattern = "network.clu"), header = F, comment.char = "#", sep = " ", colClasses = c(NA,NA,"NULL"))
        names(sol)<-c("V","cl")
    }
    
    # Remove output file of the program
    remove_file <- paste("rm ./",list.files(path = "./", pattern = "network.clu"),sep = "")
    tryCatch(system(remove_file,ignore.stdout=T),error=function(e){cat("Error in removing cluster file\n")})
    sol <- sol[order(sol[,"V"]),"cl"]
}
