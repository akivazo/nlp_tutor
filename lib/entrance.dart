import 'package:flutter/material.dart';
import 'package:nlp_tutor/chapter_loader.dart';
import 'package:nlp_tutor/chapter_viewer/chapter.dart';

class AppEntrance extends StatelessWidget {
  const AppEntrance({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, ChapterViewer>>(
      future: ChapterLoader.loadChapters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete
          return SizedBox.shrink();
        } else if (snapshot.hasError) {
          // If the future throws an error
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var chapters = snapshot.data!;
          return Scaffold(
            body: Center(
              child: SafeArea(
                child: Column(
                  children: chapters.entries.map((entry) {
                    return Card(
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => entry.value));
                          },
                          child: Text(entry.key)
                      ),
                    );
                  }).toList()
                ),
              ),
            ),
          );
        } else {
          // If the future completes but returns null
          return Text('No data available');
        }
      },

    );
  }
}
