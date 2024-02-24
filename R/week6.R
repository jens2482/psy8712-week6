# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(tidyverse)



# Data Import
citations <- stri_read_lines("../data/citations.txt", encoding = "UTF-16")
citations_txt <- str_subset(citations, pattern = "^\\S+$")
print(length(citations)-length(citations_txt))
print(mean(nchar(citations_txt)))