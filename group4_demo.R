library(tidyverse)

data <- read_csv("small_dataframe.csv")
# Clean up the note
test <- str_replace_all(data$text[1], "\\s{2,}|\n", " ")

#Start extracting
str_extract(test, "Social History:.{50}")
