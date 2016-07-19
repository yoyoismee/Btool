comm_in_density <- function(graph, membership){
    
    graph_table <- data.frame(cl = NA)
    for(i in seq_along(unique(membership))){
        graph_table[i,] <- i
        graph_table$ms <- 0
        graph_table$ns[i] <- sum(membership == i)
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

    }
    #graph_table
    in_density <- mean(2*graph_table$ms/(graph_table$ns*(graph_table$ns-1)))
    #comm_conductance <- mean(graph_table$conductance)
}