require(htmltools, quietly = TRUE)
profile <- rmarkdown::metadata$profile

optional <- function(nm, tag) if(hasName(profile, as.character(substitute(nm)))) tag

div(
  h1(profile$name),
  hr(),
  tags$ul(
    tags$li(
      a(href=sprintf("mailto:%s", profile$email), profile$email)
    ),
    tags$li(
      profile$location
    ),
    optional(github, tags$li(
      profile$github
    ))
    
  )
) |> print()