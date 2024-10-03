# excercise 2: MI filtering and network construction----

library(tidyverse)
library(igraph)
library(tidygraph)
library(ggraph)

# read data ----

mi_matrix <- read_delim(file = "mi_matrix.txt", delim = "\t")

y <- 
  mi_matrix |> 
  select(-1) |> 
  as.matrix()

rownames(y) <- mi_matrix$gene  

# diagonal by definition should be zero (avoid self loops) ----
diag(y) <- 0

################################################################################
# binarize  using a threshold ----
################################################################################

threshold <-quantile(x = y, probs = 0.9)

z <- ifelse(y >= threshold, 1, 0)

# and make a network out of it ----

g <- graph_from_adjacency_matrix(z, mode = "undirected")

mi_layout = layout_with_kk(g)
plot(g, layout = mi_layout, vertex.size = 1, vertex.label="")

# what if we try other thresholds?


################################################################################
# binarize  using a threshold ----
################################################################################
