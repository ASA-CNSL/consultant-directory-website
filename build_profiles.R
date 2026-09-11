
# Setup
build_dir <- "_site"
if (!dir.exists("profile")) dir.create("profile")

# 1. Get Data
form_responses <- readRDS("form_responses.RDS")

# 2. Loop and write .qmd files
for (i in 1:nrow(form_responses)) {
  row <- form_responses[i, ]
  email <- row[["Email address (as you'd like it to appear)"]]
  name  <- row[["Name (as you'd like it to appear)"]]
  loc   <- row[["In-person availability (if applicable, list city/state/region)"]]
  loc <- ifelse(is.na(loc), "(not specified)", loc)
  web <- row[["Website URL (optional)"]]
  if(!is.na(web)) {
    web <- gsub("https://", "", web)
    web <- paste0('https://', web) 
  } else 
    web <- "not specified"
  
  deg <- row[["Highest Degree"]]
  field <- ifelse(is.na(row[["Field of Degree"]]), "(field not specified)", row[["Field of Degree"]])
  context <- row[["Typical consulting context"]]
  lang <- row[["Languages"]]
  expertise <- row[["Area(s) of Expertise. Select up to 3."]]
  appspec <- row[["Application Specialties (up to 3)"]]
  target_file <- file.path("profile", paste0(sub("@", "_at_", email), ".qmd"))
  
  # The YAML header passes data to your .profile.qmd template
  content <- sprintf("---
title: '%s'
params:
  profile_name: '%s'
  profile_email: '%s'
  profile_location: '%s'
  profile_website: '%s'
  profile_degree: '%s, %s'
  profile_context: '%s'
  profile_language: '%s'
  profile_expertise: '%s'
  profile_appspec: '%s'
---

{{< include .profile.qmd >}}", name, name, email, loc, web, deg,
                     field, context, lang, expertise, appspec)
  
  writeLines(content, target_file)
}