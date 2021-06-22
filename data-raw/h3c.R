# See also https://github.com/paleolimbot/h3r/blob/master/data-raw/update-h3.R

## Download `h3c` and copy files to `src` dir
library(magrittr)
library(glue)

H3_VERSION <- "3.7.1"
SOURCE_URL <- glue("https://github.com/uber/h3/archive/refs/tags/v{H3_VERSION}.tar.gz")
ROOT_DIR <- "data-raw"
ARCHIVE <- file.path(ROOT_DIR, "h3-source.tar.gz")

curl::curl_download(SOURCE_URL, ARCHIVE)
untar(ARCHIVE, exdir = ROOT_DIR)
h3_folder <- list.files(ROOT_DIR, "^h3-[0-9.]+", include.dirs = TRUE, full.names = TRUE)
src_dir <- file.path(h3_folder, "src", "h3lib")

# Remove current files from `src` dir
files_to_rm <- list.files("src", full.names = TRUE) %>%
  stringr::str_subset("h3_|.cpp$|Makevars", negate = TRUE)
unlink(files_to_rm)

# Process h3api.h.in
library(stringr)
library(readr)

v_h3 <- str_split(H3_VERSION, "\\.")[[1]] %>%
  set_names(c("major", "minor", "patch"))

file.path(src_dir, "include", "h3api.h.in") %>%
  read_file() %>%
  str_replace("@H3_VERSION_MAJOR@", v_h3["major"]) %>%
  str_replace("@H3_VERSION_MINOR@", v_h3["minor"]) %>%
  str_replace("@H3_VERSION_PATCH@", v_h3["patch"]) %>%
  write_file("src/h3api.h")

# Copy new files to `src` dir
header_files <- list.files(file.path(src_dir, "include"), full.names = TRUE)
src_files <- list.files(file.path(src_dir, "lib"), full.names = TRUE)

file.copy(header_files, "src")
file.copy(src_files, "src")

unlink(ARCHIVE)
unlink(h3_folder, recursive = TRUE)

#' Reminders about manual modifications that are needed
#' - Remove brackets around <faceijk.h> in h3Index.c
