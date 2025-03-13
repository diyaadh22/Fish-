# Load necessary libraries
library(kableExtra)
library(readxl)
library(dplyr)
library(ggplot2)
library(lubridate)
library(stringr)

# Set working directory
setwd("~/Documents/fish") 

# Read data files
fish <- read_csv("fish.csv") 


# Check available sheets in the Excel file
excel_sheets("kelp_fronds.xlsx")

# Load the correct sheet
kelp_abur <- read_excel("kelp_fronds.xlsx", sheet = "abur")

# Verify column names in both datasets
print(colnames(fish))
print(colnames(kelp_abur))

# Ensure 'year' and 'site' exist in both dataframes
if (!all(c("year", "site") %in% colnames(kelp_abur))) {
  stop("Error: 'year' or 'site' column missing in kelp_abur.")
}
if (!all(c("year", "site") %in% colnames(fish))) {
  stop("Error: 'year' or 'site' column missing in fish.")
}

# Fix potential column name mismatches (renaming if needed)
kelp_abur <- kelp_abur %>%
  rename(
    year = `Year Column Name in Excel`,  # Replace if needed
    site = `Site Column Name in Excel`   # Replace if needed
  )

# Perform the inner join
kelp_fish_injoin <- kelp_abur %>%
  inner_join(fish, by = c("year", "site"))

# Display table
kable(kelp_fish_injoin) %>%
  kable_styling(bootstrap_options = "striped", full_width = FALSE)
