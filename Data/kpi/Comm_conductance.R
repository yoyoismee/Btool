comm_conductance <- function(graph, membership){
    
    graph_table <- data.frame(cl = NA)
    for(i in seq_along(unique(membership))){
        graph_table[i,] <- i
        graph_table$cs <- 0
        graph_table$ms <- 0
    }
    
    
    for(edge in E(graph)) {
        head <- as.numeric(head_of(graph, edge))
        cl_head <- membership[head]
        tail <- as.numeric(tail_of(graph, edge))
        cl_tail <- membership[tail]
        
        if(cl_head == cl_tail)
        {
            graph_table$ms[cl_head] <- graph_table$ms[cl_head]+1
        }
        else{
            graph_table$cs[cl_head] <- graph_table$cs[cl_head]+1
            graph_table$cs[cl_tail] <- graph_table$cs[cl_tail]+1
        }
    }
        #graph_table
        conductance <- mean(graph_table$cs/(graph_table$cs+2*graph_table$ms))
        #comm_conductance <- mean(graph_table$conductance)
}