import 'package:flutter/material.dart';
import 'package:nlp_tutor/entrance.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details); // Log the error
    debugPrint('Caught Flutter error: ${details.exception}');
  };
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(child: AppEntrance())
    );
  }
}
