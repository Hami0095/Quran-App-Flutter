// Define a map of custom dark green color swatches
import 'package:flutter/material.dart';

Map<int, Color> customDarkGreenSwatch = {
  50: const Color.fromRGBO(16, 82, 19, .1),
  100: const Color.fromRGBO(16, 82, 19, .2),
  200: const Color.fromRGBO(16, 82, 19, .3),
  300: const Color.fromRGBO(16, 82, 19, .4),
  400: const Color.fromRGBO(16, 82, 19, .5),
  500: const Color.fromRGBO(16, 82, 19, .6),
  600: const Color.fromRGBO(16, 82, 19, .7),
  700: const Color.fromRGBO(16, 82, 19, .8),
  800: const Color.fromRGBO(16, 82, 19, .9),
  900: const Color.fromRGBO(16, 82, 19, 1),
};

// Create a MaterialColor from the swatch map
MaterialColor customDarkGreen =
    MaterialColor(0xFF105213, customDarkGreenSwatch);
