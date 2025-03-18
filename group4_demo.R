library(tidyverse)

data <- read_csv("small_dataframe.csv")

cat(data$text[1])
# Clean up the note
randSample <- sample(1:nrow(data), 6)
test <- str_replace_all(data$text[randSample], "\\s{2,}|\n", " ")

#Start extracting
chiefComplaints <- str_match(test, "Chief Complaint:(.*)Major Surgical or Invasive Procedure:")[,2]

data$text[randSample[3]] |> cat()
