#' @title Install dependencies
#'
#' @description Downloads and unpacks the framework's source code from GitHub.
#' This process creates a new folder, called HyperSpark-master in the working
#' directory.
#'
#' @param NULL
#'
#' @return NULL
#'
#' @examples dependencies()
#'
#' @export dependencies

dependencies <- function(){
  install_hyperspark <- function(){
    # Download and unzip HyperSpark from github
    f = "https://github.com/jarnos97/hyperspark-1/archive/refs/heads/master.zip"
    download.file(f, destfile = "hyperspark.zip")
    unzip(zipfile = "hyperspark.zip")
  }

  # Install HyperSpark source code
  print("Downloading HyperSpark, this might take a while")
  install_hyperspark()
  print("Downloading and unpacking finished.")
}
