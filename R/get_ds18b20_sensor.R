#' @export
get_ds18b20_sensor <- function() {
  # Raspberry's 1-wire directory.
  base_dir <- "/sys/bus/w1/devices/"
  # ds18b20 starts with 28 ; get the first one.
  # TODO: Research how to change this pin, or use multiple pins.
  device_folder <- dir(base_dir, pattern = "^28", full.names = TRUE)[1]
  # This is the file where the temperature is stored.
  device_file <- paste0(device_folder, "/w1_slave")
  # Check for errors.
  if (is.na(device_folder) || !file.exists(device_file))
    stop("Sensor not found, or not configured.")
  # Return the structure.
  ds18b20 <- list(pin = 4, device_file = device_file)
  attr(ds18b20, "class") <- "ds18b20"
  ds18b20
}
