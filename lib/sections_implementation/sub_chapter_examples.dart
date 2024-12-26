import 'package:flutter/material.dart';

class SubChapterExamples extends StatelessWidget {
  final List<String> examples;

  const SubChapterExamples({super.key, required this.examples});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Examples:"),
        Expanded(
          child: Center(
            child: ListView(
              children: examples.map((example) => Text(example)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
