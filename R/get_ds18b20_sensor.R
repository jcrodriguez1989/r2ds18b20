#' Get a DS18B20 sensor instance.
#'
#' Returns a DS18B20 sensor instance ready to get its temperature.
#' The sensor should be set to use with the Raspberry's 1-Wire protocol.
#'
#' @param sensor_id A character of length one with the ID of the sensor to use,
#'   as found in the `/sys/bus/w1/devices/` directory. If `NA`, it will return
#'   the first sensor found. This parameter should be used only if more than one
#'   DS18B20 sensor is connected. Defaults to `NA`.
#'
#' @examples
#' \dontrun{
#' # If just one sensor connected, this would be the normal use case.
#' sensor <- get_ds18b20_sensor()
#'
#' # If two sensors connected, say "28-0300a2790676" and "28-0300a0881918".
#' sensor_1 <- get_ds18b20_sensor("28-0300a2790676")
#' sensor_2 <- get_ds18b20_sensor("28-0300a0881918")
#' }
#'
#' @export
#'
get_ds18b20_sensor <- function(sensor_id = NA) {
  # Raspberry's 1-wire directory.
  base_dir <- "/sys/bus/w1/devices/"
  if (is.na(sensor_id)) {
    # ds18b20 starts with 28; if no sensor_id given get the first sensor found.
    device_folder <- dir(base_dir, pattern = "^28", full.names = TRUE)[1]
  } else {
    device_folder <- paste0(base_dir, sensor_id)
  }
  # This is the file where the temperature is stored.
  device_file <- paste0(device_folder, "/w1_slave")
  # Check for errors.
  if (is.na(device_folder) || !file.exists(device_file))
    stop("Sensor not found, or not configured.")
  # Return the structure.
  sensor <- list(device_file = device_file)
  attr(sensor, "class") <- "ds18b20"
  sensor
}
