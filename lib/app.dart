import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class GuessWordApp extends StatelessWidget {
  const GuessWordApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      routerConfig: routes,
      title: 'Guess the Word',
    );
  }
}
