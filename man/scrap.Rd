% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scrap.R
\name{scrap}
\alias{scrap}
\title{Simple website scraping}
\usage{
scrap(link, node, clean = FALSE, askRobot = FALSE)
}
\arguments{
\item{link}{the link of the web page to scrape}

\item{node}{the HTML or CSS element to consider, the SelectorGadget tool is highly recommended}

\item{clean}{logical. Should the function clean the extracted vector or not ? Default is FALSE.}

\item{askRobot}{logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.}
}
\value{
a character vector
}
\description{
This function is used to scrape one element from a website.
}
\examples{
\donttest{
# Extracting imdb top 250 movie titles
  link <- "https://www.imdb.com/chart/top/"
  node <- "h3.ipc-title__text"
  scrap(link, node)
}

}
