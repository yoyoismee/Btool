Copra5 <- function(file){
    # Executing external program Infomap to calculate cluster
    copra5 <- paste("java -cp ./Data/algorithm/exe/copra.jar COPRA ","./Data/dataset/",file," -mo -repeat 5",sep = "")
    tryCatch(system(copra5,ignore.stdout=T),error=function(e){cat("Error in executing copra.jar program\n")})
    if(file.exists(paste("./best-clusters-",file,sep = ""))){
        lines <- readLines(paste("./best-clusters-",file,sep = ""))
        
        output_community <- data.frame(cl=NA,Added = NA)
        for(com in seq_along(lines)){
            V <- as.numeric(strsplit(lines[com], " ")[[1]])
            output_community[as.numeric(V)+1,]$cl<- com
            output_community[as.numeric(V)+1,]$Added<- T
            #output_community[as.numeric(V)+1,]$V <-as.numeric(V)    
        }
        output_community <- na.omit(output_community[output_community$Added,])
       # output_community[is.na(output_community$cl),2] <- cl+names(sol)<-c("V","cl")
    }
    
    # Remove output file of the program
    remove_file <- paste("rm ./best-clusters-",file, " ./clusters-",file, sep = "")
    tryCatch(system(remove_file,ignore.stdout=T),error=function(e){cat("Error in removing cluster file\n")})
    
    #Output
    output_community <- output_community$cl
}
