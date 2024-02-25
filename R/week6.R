# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(tidyverse)



# Data Import
citations <- stri_read_lines("../data/citations.txt", encoding = "CP-1250")
citations_txt <- str_subset(citations, pattern = "\\S+")
print(length(citations)-length(citations_txt))
print(mean(nchar(citations_txt)))

# Data Cleaning
sample_n(citations_tbl, size = 20)

citations_tbl <- tibble(line = seq_along(citations_txt), cite = citations_txt) %>%
  mutate(cite = str_remove_all(cite, pattern = "[\"']")) %>%
  mutate(year = str_extract(cite, pattern = "\\d{4}")) %>%
  mutate(page_start = str_extract(cite, pattern = "\\d{1,4}(?=-)")) %>%
  mutate(perf_ref = grepl("[Pp]erformance", cite)) %>%
  mutate(title = str_extract(cite, pattern = "(?<=\\)\\.*? )\\b(?:\\S+? )*\\S+?[\\.\?] ")) %>%
  mutate(first_author = str_extract(cite, pattern = "^\\w*, \\w\\.(?: \\w\\.)?"))

print(sum(citations_tbl$first_author != "", na.rm = TRUE))