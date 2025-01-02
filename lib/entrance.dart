import 'package:flutter/material.dart';
import 'package:nlp_tutor/chapter_loader.dart';
import 'package:nlp_tutor/chapter_viewer/chapter.dart';

class ChapterNavigationButton extends StatelessWidget {
  final String chapterName;
  final ChapterViewer chapter;

  const ChapterNavigationButton({super.key, required this.chapterName, required this.chapter});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => chapter));
    },
    child: Text(chapterName));
  }

}
class AppEntrance extends StatelessWidget {
  final Map<String, ChapterViewer> chapters;
  const AppEntrance({super.key, required this.chapters});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: Center(
            child: SafeArea(
              child: Column(
                children: chapters.entries.map((entry) {
                  return Card(
                    child: ChapterNavigationButton(chapterName: entry.key, chapter: entry.value)
                  );
                }).toList()
              ),
            ),
          ),
        );
  }
}
