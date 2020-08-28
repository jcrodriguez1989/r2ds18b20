#' Ds18b20 Class Representation.
#'
#' @slot device_file The sensor's configuration file.
#'
#' @importFrom methods setClass
#'
setClass(
  "Ds18b20",
  slots = c(
    device_file = "character"
  )
)
