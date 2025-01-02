import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:nlp_tutor/chapter_viewer/chapter.dart';
import 'package:nlp_tutor/chapter_viewer/sub_chapter.dart';

void main() {
  group('ChapterViewer Tests', () {
    late List<SubChapterViewer> mockSubChapters;

    setUp(() {
      mockSubChapters = [
        SubChapterViewer(
          title: 'SubChapter 1',
          sections: [
            const Text('Section 1.1'),
            const Text('Section 1.2'),
          ],
        ),
        SubChapterViewer(
          title: 'SubChapter 2',
          sections: [
            const Text('Section 2.1'),
            const Text('Section 2.2'),
          ],
        ),
      ];
    });

    testWidgets('Initial state displays the first section of the first subchapter', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ChapterViewer(subChapters: mockSubChapters),
      ));

      expect(find.text('SubChapter 1'), findsOneWidget); // Check AppBar title
      expect(find.text('Section 1.1'), findsOneWidget); // Check first section
    });

    testWidgets('NextSectionButton navigates to the next section within the same subchapter', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ChapterViewer(subChapters: mockSubChapters),
      ));

      expect(find.text('Section 1.1'), findsOneWidget);

      await tester.tap(find.byType(NextSectionButton));
      await tester.pumpAndSettle();

      expect(find.text('Section 1.2'), findsOneWidget);
    });

    testWidgets('NextSectionButton navigates to the next subchapter after the last section', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ChapterViewer(subChapters: mockSubChapters),
      ));

      await tester.tap(find.byType(NextSectionButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(NextSectionButton));
      await tester.pumpAndSettle();

      expect(find.text('SubChapter 2'), findsOneWidget); // Check AppBar title
      expect(find.text('Section 2.1'), findsOneWidget); // Check first section of next subchapter
    });

    testWidgets('LastSectionButton navigates to the previous section within the same subchapter', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ChapterViewer(subChapters: mockSubChapters),
      ));

      await tester.tap(find.byType(NextSectionButton));
      await tester.pumpAndSettle();

      expect(find.text('Section 1.2'), findsOneWidget);

      await tester.tap(find.byType(LastSectionButton));
      await tester.pumpAndSettle();

      expect(find.text('Section 1.1'), findsOneWidget);
    });

    testWidgets('LastSectionButton navigates to the previous subchapter after the first section', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ChapterViewer(subChapters: mockSubChapters),
      ));

      await tester.tap(find.byType(NextSectionButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(NextSectionButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(LastSectionButton));
      await tester.pumpAndSettle();

      expect(find.text('SubChapter 1'), findsOneWidget); // Check AppBar title
      expect(find.text('Section 1.2'), findsOneWidget); // Check previous section
    });

    testWidgets('Swiping left and right navigates between sections', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ChapterViewer(subChapters: mockSubChapters),
      ));

      // Swipe left to next section
      await tester.fling(find.byType(Scaffold), const Offset(-300, 0), 1000);
      await tester.pumpAndSettle();

      expect(find.text('Section 1.2'), findsOneWidget);

      // Swipe right to previous section
      await tester.fling(find.byType(Scaffold), const Offset(300, 0), 1000);
      await tester.pumpAndSettle();

      expect(find.text('Section 1.1'), findsOneWidget);
    });
  });
}
