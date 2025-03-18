library(tidyverse)

person <- data.frame(
  name = c("PJ", "Arushi", "Arian"),
  age = c(35, 27, 25),
  city = c("Roxbury", "Brookline", "Beacon Hill")
)

output <- data.frame()

for(i in 1:nrow(person)){
  resp <- sprintf("My name is %s and I am %i years old and live in %s", 
          person$name[i], person$age[i], person$city[i]
      )
   output <- rbind(output, data.frame(i = i, resp = resp))
}

output