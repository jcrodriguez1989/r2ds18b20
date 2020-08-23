#' @export
get_temperature <- function (x, ...) UseMethod("get_temperature", x)

#' @export
get_temperature.ds18b20 <- function(x, scale = "celsius", max_retries = 10) {
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
