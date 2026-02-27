require(htmltools, quietly = TRUE)
profile <- rmarkdown::metadata$profile


div(
  h1(profile$name),
  hr(),
  tags$ul(
    tags$li(
      a(href=sprintf("mailto:%s", profile$email), profile$email)
    ),
    tags$li(
      profile$location
    )
    
  )
) |> print()