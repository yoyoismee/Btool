comm_cutratio <- function(graph, membership){
    
    graph_table <- data.frame(cl = NA)
    for(i in seq_along(unique(membership))){
        graph_table[i,] <- i
        graph_table$cs <- 0
        graph_table$ns[i] <- sum(membership == i)
    }
    
    
    for(edge in E(graph)) {
        head <- as.numeric(head_of(graph, edge))
        cl_head <- membership[head]
        tail <- as.numeric(tail_of(graph, edge))
        cl_tail <- membership[tail]
        
        if(cl_head != cl_tail){
            graph_table$cs[cl_head] <- graph_table$cs[cl_head]+1
            graph_table$cs[cl_tail] <- graph_table$cs[cl_tail]+1
        }
    }
    #graph_table
    cut_ratio <- mean(graph_table$cs/((length(V(graph))-graph_table$ns)*graph_table$ns))
    #comm_conductance <- mean(graph_table$conductance)
}