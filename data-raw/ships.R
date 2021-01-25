## code to prepare `ships` dataset
# since this is a rather large file, we don't save a local copy of the raw csv
# note: file needs to be in your google drive (i.e. you need to have viewed it)
# as this is not my file, i don't want to share it without permission
# also, will need to authorize googledrive package to access your google drive

library(tidyverse)
library(googledrive)
library(geodist)

# ---- download and read file ----

temp_dir <- tempdir()

# will ask to save/retrieve auth token
file <- drive_get("ships_04112020.zip")

downloaded_file <- drive_download(
  as_id(file$id),
  path = paste0(temp_dir, "/", "ships.zip"),
  overwrite = TRUE
)

ships_raw <- read_csv(downloaded_file$local_path)

# ---- clean up data -----
# this is fairly basic cleaning
# would need more domain knowledge or a domain expert's input

ships <- ships_raw %>%
  select(
    lat = LAT,
    lon = LON,
    date_time = DATETIME,
    ship_type,
    ship_name = SHIPNAME,
    ship_id = SHIP_ID
  )

# keep only ships with at least 2 observations
# otherwise, we can't compute a distance
ships <- ships %>%
  add_count(ship_id) %>%
  filter(n >= 2) %>%
  select(-n)

# some ships have only numbers as their names
# these numbers don't match the ship's id number
# there are 9 such ships and ~22k observations
# having a number only name doesn't seem right
# but I couldn't confirm or deny this after some researching
# we should consult a domain expert to resolve this
# for now, let's remove them to save space/computation

ships <- ships %>%
  mutate(
    # of the form '1243' or '12-34'
    only_number_name = str_detect(ship_name, "^(\\d*\\-?\\d*)$")
  ) %>%
  filter(!only_number_name) %>%
  select(-only_number_name)

# clean up ship names
# 	". PRINCE OF WAVES" and "PRINCE OF WAVES" are the same ship (same ship id)
ships <- ships %>%
  mutate(
    ship_name = if_else(ship_name == ". PRINCE OF WAVES",
                        "PRINCE OF WAVES",
                        ship_name
                        ),
    ship_name = str_replace_all(ship_name, "\\[|\\]", ""), # replace '[' or ']'
    ship_name = str_remove(ship_name, "^\\."), # remove leading '.'
    ship_name = str_trim(ship_name) # remove leading and trailing white space
  )


# ensure observations are in the correct order before computing distances
# note there are some ships with the same name but different id and type
# so we use ship id as the unique identifier
ships <- ships %>%
  arrange(ship_id, date_time) %>%
  select(-date_time)

# ---- add distances ----
ships <- ships %>%
  group_by(ship_id) %>%
  mutate(
    distance = geodist_vec(lon,
                           lat,
                           sequential = TRUE,
                           pad = TRUE,
                           measure = "geodesic"
                           )
  ) %>%
  ungroup()


ships <- ships %>%
  group_by(ship_id) %>%
  mutate(
    max_distance = max(distance, na.rm = TRUE)
  ) %>%
  ungroup()

# let's assume we only want to see ships who traveled some positive distance
# we keep the records where the ship traveled the longest distance and the
#  previous record
# we use which(x == max(x)) because which.max(x) only returns the first
#  instance of the max
# we select the last (most recent) max by using tail(x, 1)
# ex: x <- c(1, 2, 3, 3); which.max(x); which(x == max(x));
ships <- ships %>%
  group_by(ship_id) %>%
  filter(max_distance > 0) %>%
  mutate(
    one_before_max_idx =
      tail(which(distance == max(distance, na.rm = TRUE)), 1) - 1,
    max_idx = tail(which(distance == max(distance, na.rm = TRUE)), 1)
  ) %>%
  slice(
    one_before_max_idx[1]:max_idx[1]
  ) %>%
  ungroup()

ships <- ships %>%
  select(
    lat,
    lon,
    ship_type,
    ship_name,
    max_distance
  )

# ---- save ----
usethis::use_data(ships, overwrite = TRUE)
