import 'dart:async';
import 'dart:developer';

import 'package:filmfan/app/app.dart';
import 'package:flutter/material.dart';

void main() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(
      const App(),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
