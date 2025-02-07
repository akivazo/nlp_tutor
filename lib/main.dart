import 'package:flutter/material.dart';
import 'package:nlp_tutor/chapter_loader.dart';
import 'package:nlp_tutor/chapter_viewer/chapter.dart';
import 'package:nlp_tutor/entrance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp(chapters: await ChapterLoader().loadChapters(),));
}
// new version
class MainApp extends StatelessWidget {
  final Map<String, ChapterViewer> chapters;
  const MainApp({super.key, required this.chapters});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: AppEntrance(chapters: chapters,))
    );
  }
}
