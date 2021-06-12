#' @title Install dependencies
#'
#' @description Installs the dependencies, including HyperSpark source code from
#'   Github.
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
