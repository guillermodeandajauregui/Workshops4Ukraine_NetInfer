# excercise 2: MI calculation----

library(tidyverse)
library(infotheo)

# read data ----

x <- read_delim(file = "gene_data.txt", delim = "\t")

# make it a matrix 
y <- 
  x |> 
  select(-c(1:2)) |> 
  as.matrix()

rownames(y) <- x$hgnc_symbol


# discretize data ----

## we will convert each row into a discrete variable 

y[1:5, 1:5]

tibble(x = y[1,],
       y = discretize(X = y[1,], disc = "equalfreq", )
       ) |> 
  group_by(y) |> 
  tally()

y_list <- split(y, row(y))
names(y_list) <- rownames(y)

y_discretized <- 
  lapply(y_list, function(i){
  discretize(X = i, 
             disc = "equalfreq", 
             nbins = round(length(i)^(1/3))) |> 
      unlist() |> as.numeric()
                        }
  )



# calculate MI ----


