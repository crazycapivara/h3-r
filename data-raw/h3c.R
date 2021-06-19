## Download `h3c` and copy files to `src` dir
library(magrittr)
library(glue)

H3_VERSION <- "v3.3.0"
SOURCE_URL <- glue("https://github.com/uber/h3/archive/refs/tags/{H3_VERSION}.tar.gz")
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

# Copy new file to `src` dir
header_files <- list.files(file.path(src_dir, "include"), full.names = TRUE)
src_files <- list.files(file.path(src_dir, "lib"), full.names = TRUE)

file.copy(header_files, "src")
file.copy(src_files, "src")

unlink(h3_folder, recursive = TRUE)
