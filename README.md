r2ds18b20 - R to DS18B20
================

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

Control your Raspberry Pi’s DS18B20 temperature sensor from R.

## Installation

`r2ds18b20` is currently only available as a GitHub package.

To install it run the following from an R console:

``` r
if (!require("remotes")) {
  install.packages("remotes")
}
remotes::install_github("jcrodriguez1989/r2ds18b20", dependencies = TRUE)
```

## Prerequisites

### Sensor Connection

The `r2ds18b20` package requires that your DS18B20 sensor is correctly
connected in your Raspberry Pi’s GPIO.

The default setting for you DS18B20 sensor would be following this
wiring diagram:

![Image from Pi My Life
Up](https://pi.lbbcdn.com/wp-content/uploads/2016/03/Raspberry-Pi-Temperature-Sensor-Diagram-v2.png)

The resistor should be 4.7K or 10K Ohm.

The data pin must be the GPIO4 (as in the diagram). If it is connected
to another pin, then additional configuration should be addressed. More
information could be find at [this
post](https://raspberrypi.stackexchange.com/questions/38054/change-gpio-pin-for-ds18b20-one-wire-digital-temperature-sensor).

### Enabling the Interface

Raspberry Pi’s 1-Wire interface should be enabled. Make sure that the
`1-Wire:` interface is enabled, you could check out this by following
these steps:

![Images from
raspberrypi-spy](https://www.raspberrypi-spy.co.uk/wp-content/uploads/2014/08/rc_gui_launch.jpg)![Images
from
raspberrypi-spy](https://www.raspberrypi-spy.co.uk/wp-content/uploads/2018/02/rc_gui_interfaces_1wire.png)

## Usage

``` r
# Load the library.
library("r2ds18b20")
# Get a DS18B20 sensor instance.
sensor <- get_ds18b20_sensor()
# Read the temperature.
get_temperature(sensor)
```

## Aditional Notes

  - More than one DS18B20 can be used, please refer to [this
    post](https://raspberryautomation.com/connect-multiple-ds18b20-temperature-sensors-to-a-raspberry-pi/)
    to learn how-to.
