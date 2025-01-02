import 'package:flutter/material.dart';

class SubChapterExplanation extends StatelessWidget {
  final String explanation;
  const SubChapterExplanation({super.key, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Text(explanation);
  }
}
