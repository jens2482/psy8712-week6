# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(tidyverse)



# Data Import
citations <- stri_read_lines("../data/citations.txt", encoding = "ISO-8859-1")
citations_txt <- str_subset(citations, pattern = "\\S+")
#citations_txt <- citations[!stri_isempty(citations)] #alternate to code above (preferred as it does not use regex)
print(length(citations)-length(citations_txt))
print(mean(nchar(citations_txt)))

# Data Cleaning
sample_n(citations_tbl, size = 20) %>%
  View
citations_tbl <- tibble(line = seq_along(citations_txt), cite = citations_txt) %>%
#citations_tbl <- tibble(line = 1:length(citations_txt), cite - citations_txt) %>% #alternate text to row above
  mutate(cite = str_remove_all(cite, pattern = "[\"']")) %>%
  mutate(year = as.integer(str_extract(cite, pattern = "\\d{4}"))) %>% #needed to change values to integers
  mutate(page_start = as.integer(str_extract(cite, pattern = "\\d{1,4}(?=-)"))) %>%
  #str_match(cite, "(\\d+_-\\d+ [,2])) # alternative function to line above
  mutate(perf_ref = str_detect(str_to_lower(cite), "performance")) %>%
  mutate(title = str_match(cite, "\\d{4}\\)\\. ([^\\.]+)")[,2]) %>%
  mutate(first_author = str_extract(cite, "^\\w+, \\w\\.? ?\\w?\\.? ?\\w?\\."))

print(sum(citations_tbl$first_author != "", na.rm = TRUE))
#sum(!is.na(citations_tbl$first_author))  #simpler way