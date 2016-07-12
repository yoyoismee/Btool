Cfinder3 <- function(file){
    # Executing external program Infomap to calculate cluster
    cfinder3 <- paste("./Data/algorithm/exe/CFinder_commandline64 -i ","./Data/dataset/",file," -l ./Data/algorithm/exe/licence.txt",sep = "")
    tryCatch(system(cfinder3,ignore.stdout=T),error=function(e){cat("Error in executing CFinder3 program\n")})
    
    # Read output file and put in structured format
    if(dir("./Data/dataset", recursive = F, pattern = "*network.txt_files") != "NA"){
        filepath = paste("./Data/dataset/", dir("./Data/dataset", recursive = F, pattern = "*network.txt_files"),"/k=3/communities",sep = "")
        lines <- readLines(con = filepath)
        lines <- lines[8:length(lines)]
        
        output_community <- data.frame(V=1,cl=NA)
        
        for(com in lines){
            com <- (strsplit(trimws(com),":"))
            cl <- as.numeric(com[[1]][1])+1
            V <- strsplit(trimws(com[[1]][2])," ")[[1]]
            output_community[as.numeric(V),]$cl<-cl
        }
        output_community[1:nrow(output_community),]$V <-1:nrow(output_community)
        output_community[is.na(output_community$cl),2] <- cl+1
        
        # Remove output file of the program
        remove_file <- paste("rm -rf ./Data/dataset/",file,"_files",sep = "")
        tryCatch(system(remove_file,ignore.stdout=T),error=function(e){cat("Error in removing cluster file\n")})
        
        #Output membership vector
        output_community$cl
    }
}