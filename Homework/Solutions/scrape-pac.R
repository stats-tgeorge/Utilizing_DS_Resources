# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(here) 
library(janitor)
# function: scrape_pac ---------------------------------------------------------

scrape_pac <- function(url) {
  
  # read the page
  page <- read_html(url)
  
  # exract the table
  pac <-  page %>%
    # select node .DataTable (identified using the SelectorGadget)
    html_node(".DataTable-Partial") %>%
    # parse table at node td into a data frame
    #   table has a head and empty cells should be filled with NAs
    html_table("td", header = T) %>%
    # convert to a tibble
    as_tibble()
  
  # rename variables
  pac <- pac %>%
    # rename columns
    rename(
      name = "PAC Name (Affiliate)",
      country_parent = "Country of Origin/Parent Company",
      total = "Total",
      dems = "Dems",
      repubs = "Repubs"
    )
  
  # fix name
  pac <- pac %>%
    # remove extraneous whitespaces from the name column
    mutate(name = str_squish(name))
  
  # add year
  pac <- pac %>%
    # extract last 4 characters of the URL and save as year
    mutate(year = str_sub(url,end=-4))
  
  # return data frame
  pac
  
}

# test function ----------------------------------------------------------------

url_2022 <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs/2022"

pac_2022 <- scrape_pac(url_2022)

url_2018 <- "___"
pac_2018 <- scrape_pac(___)

url_1998 <- "___"
pac_1998 <- scrape_pac(___)

# list of urls -----------------------------------------------------------------

# first part of url
root <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs/"

# second part of url (election years as a sequence)
year <- seq(from = 2000, to = 2022, by = 2)

# construct urls by pasting first and second parts together
urls <- paste0(root, year)

# map the scrape_pac function over list of urls --------------------------------

pac_all <- map_dfr(urls, scrape_pac)

# write data -------------------------------------------------------------------

write_csv(pac_all, file = here::here("c:/users/chewy/desktop/pac-all.csv"))
