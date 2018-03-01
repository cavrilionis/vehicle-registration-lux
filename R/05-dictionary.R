
# Names

dict.names <- as.data.frame(colnames(vehcln), stringsAsFactors = FALSE)
dict.names <- rename(dict.names, "Column.name" = "colnames(vehcln)")

# Order
dict.order <- tibble::rownames_to_column(dict.names, var = "Order")

# Labels
dict.labels <- as.data.frame(label(vehcln))
dict.labels <- tibble::rownames_to_column(dict.labels, var = "Column.name")
dict.labels <- rename(dict.labels, "Column.label" = "label(vehcln)")

# Class
dict.class <- as.data.frame(lapply(vehcln, class))
dict.class <- gather(dict.class)
dict.class <- filter(dict.class, value != "labelled")
dict.class

# Class
class(vehcln$INFNOX)
typeof(vehcln$INFNOX)
str(vehcln$INFNOX)

dict.typeof <- as.data.frame(sapply(vehcln, typeof))
dict.typeof <- gather(dict.typeof)
dict.typeof <- filter(dict.typeof, value != "labelled")
dict.typeof

dict <- inner_join(dict.order, dict.labels, by = "Column.name")
View(dict)

detach(devtools)
list.df.var.types(vehcln)


