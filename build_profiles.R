library(googlesheets4)
library(dplyr)

# Setup
build_dir <- "_site"
if (!dir.exists("profile")) dir.create("profile")

# 1. Get Data
form_responses <- read_sheet('https://docs.google.com/spreadsheets/d/1CKpngSWGC54YHUHwbOCyraWKOSkCoc4rzbvJWg3ZlqM/edit?usp=sharing')

# 2. Loop and write .qmd files
for (i in 1:nrow(form_responses)) {
  row <- form_responses[i, ]
  email <- row[["Email address (as you'd like it to appear)"]]
  name  <- row[["Name (as you'd like it to appear)"]]
  loc   <- row[["In-person availability (if applicable, list city/state/region)"]]
  
  target_file <- file.path("profile", paste0(sub("@", "_at_", email), ".qmd"))
  
  # The YAML header passes data to your .profile.qmd template
  content <- sprintf("---
title: '%s'
params:
  profile_name: '%s'
  profile_email: '%s'
  profile_location: '%s'
---

{{< include .profile.qmd >}}", name, name, email, loc)
  
  writeLines(content, target_file)
}