#' Get the temperature of a sensor instance.
#'
#' Reads the temperature of a given sensor instance.
#'
#' @param x A sensor instance.
#' @param ... further arguments passed to or from other methods.
#'
#' @return A numeric of length one with the read temperature in the selected
#'   `scale`. In case of error, it will return `NA`.
#'
#' @examples
#' \dontrun{
#' # Get a DS18B20 sensor instance.
#' sensor <- get_ds18b20_sensor()
#' # Read the temperature.
#' get_temperature(sensor)
#' }
#'
#' @export
#'
get_temperature <- function (x, ...) UseMethod("get_temperature")

#' Get the temperature of a DS18B20 sensor instance.
#'
#' Reads the temperature of a given sensor instance.
#'
#' @param x A sensor instance.
#' @param scale One of `"celsius"`, `"fahrenheit"` or `"kelvin"`, indicating
#'   the desired return scale.
#' @param max_retries A numeric of length one indicating how many times it
#'   should retry in case of issues.
#' @param ... further arguments passed to or from other methods.
#'
#' @return A numeric of length one with the read temperature in the selected
#'   `scale`. In case of error, it will return `NA`.
#'
#' @examples
#' \dontrun{
#' # Get a DS18B20 sensor instance.
#' sensor <- get_ds18b20_sensor()
#' # Read the temperature in Celsius and in Fahrenheit.
#' get_temperature(sensor)
#' get_temperature(sensor, "fahrenheit")
#' }
#'
#' @export
#'
get_temperature.ds18b20 <- function(x, scale = "celsius", max_retries = 10, ...) {
  retries <- 1
  device_file <- x$device_file
  # Try to read the temperature from the device file.
  file_lines <- readLines(device_file)
  while (!grepl("YES$", file_lines[1]) && retries < max_retries) {
    # If "YES" code not found, sleep 0.2 and retry.
    Sys.sleep(0.2)
    retries <- retries + 1
    file_lines <- readLines(device_file)
  }
  if (!grepl("YES$", file_lines[1]))
    return(NA)
  # Temperature is after the "t=" string.
  temp <- as.numeric(gsub(".*t=", "", file_lines[2])) / 1000
  switch (scale,
    celsius = temp,
    fahrenheit = temp * (9 / 5) + 32.0,
    kelvin = temp + 273.15,
    {
      warning('`scale` must be one of "celsius", "fahrenheit", "kelvin"')
      NA
    }
  )
}
