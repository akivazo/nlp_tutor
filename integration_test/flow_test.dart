


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nlp_tutor/chapter_model/chapter_schema.dart';
import 'package:nlp_tutor/chapter_viewer/chapter.dart';
import 'package:nlp_tutor/chapter_viewer/sub_chapter.dart';
import 'package:nlp_tutor/entrance.dart';
import 'package:nlp_tutor/main.dart' as app;
import 'package:nlp_tutor/sections_implementation/multi_part_question.dart';
import 'package:nlp_tutor/sections_implementation/question_viewer.dart';
import 'package:nlp_tutor/sections_implementation/sub_chapter_examples.dart';
import 'package:nlp_tutor/sections_implementation/sub_chapter_explanation.dart';
import 'package:nlp_tutor/sections_implementation/sub_chapter_video.dart';




void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test app flow', (WidgetTester tester) async {

    var chapters = {
      'Chapter 1': ChapterViewer(subChapters: [
        SubChapterViewer(title: "sub chapter 1.1", sections: [Text("section1.1.1"), Text("section1.1.2")],),
        SubChapterViewer(title: "sub chapter 1.2", sections: [Text("section1.2.1"), Text("section1.2.2")],),

      ]),
      'Chapter 2': ChapterViewer(subChapters: [
        SubChapterViewer(title: "sub chapter 2.1", sections: [Text("section2.1.1"), Text("section2.1.2")],),
        SubChapterViewer(title: "sub chapter 2.2", sections: [Text("section2.2.1"), Text("section2.2.2")],),

      ]),
    };

    // start app
    app.main();

    await tester.pumpAndSettle();

    expect(find.byType(AppEntrance), findsOne);

    // enter chapter
    expect(find.byType(ChapterNavigationButton), findsAtLeast(1));

    await tester.tap(find.byType(ChapterNavigationButton).first);

    await tester.pumpAndSettle();

    expect(find.byType(ChapterViewer), findsOne);

    expect(find.byType(LastSectionButton), findsOne);

    expect(find.byType(NextSectionButton), findsOne);

    expect(find.byType(SubChapterExplanation), findsOne);

    // move to examples
    
    await tester.tap(find.byType(NextSectionButton));

    await tester.pumpAndSettle();

    expect(find.byType(SubChapterExamples), findsOne);

    // move to video
    await tester.tap(find.byType(NextSectionButton));

    await tester.pumpAndSettle();

    expect(find.byType(SubChapterVideo), findsOne);

    // move to first question
    await tester.tap(find.byType(NextSectionButton));

    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is QuestionViewer), findsOne);

    // move to second question
    await tester.tap(find.byType(NextSectionButton));

    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is QuestionViewer), findsOne);

    // go back

    await tester.tap(find.byType(LastSectionButton));

    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is QuestionViewer), findsOne);

    // go back

    await tester.tap(find.byType(LastSectionButton));

    await tester.pumpAndSettle();

    expect(find.byType(SubChapterVideo), findsOne);

    // go back to home page

    await tester.tap(find.byType(LastPageButton));

    await tester.pumpAndSettle();

    expect(find.byType(AppEntrance), findsOne);
  });
}


