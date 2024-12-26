import 'package:flutter/material.dart';

class SucChapterExplanation extends StatelessWidget {
  final String explanation;
  const SucChapterExplanation({super.key, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Text(explanation);
  }
}
