import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:nlp_tutor/sections_implementation/multi_part_question.dart';

void main() {
  group('MultiPartQuestionViewer Tests', () {
    const String question = 'What is 2 + 2?';
    const String rightOption = '4';
    const List<String> wrongOptions = ['3', '5', '6'];
    const String correctResponse = 'Correct!';
    const String wrongResponse = 'Wrong! Try again.';

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: MultiPartQuestionViewer(
            question: question,
            rightOption: rightOption,
            wrongOptions: wrongOptions,
            correctResponse: correctResponse,
            wrongResponse: wrongResponse,
          ),
        ),
      );
    }

    testWidgets('Displays the question and options', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(question), findsOneWidget); // Check question text
      expect(find.text(rightOption), findsOneWidget); // Check right option
      for (final wrongOption in wrongOptions) {
        expect(find.text(wrongOption), findsOneWidget); // Check each wrong option
      }
    });

    testWidgets('Displays correct response when right option is selected', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text(rightOption));
      await tester.pumpAndSettle();

      expect(find.text(correctResponse), findsOneWidget); // Correct response
      expect(find.text(wrongResponse), findsNothing); // No wrong response
    });

    testWidgets('Displays wrong response when a wrong option is selected', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text(wrongOptions.first));
      await tester.pumpAndSettle();

      expect(find.text(wrongResponse), findsOneWidget); // Wrong response
      expect(find.text(correctResponse), findsNothing); // No correct response
    });

    testWidgets('Options are shuffled on widget creation', (WidgetTester tester) async {
      List<String> initialOrder;
      await tester.pumpWidget(createWidgetUnderTest());

      initialOrder = tester.widgetList(find.byType(TextButton)).map((widget) {
        final button = widget as TextButton;
        return (button.child as Text).data!;
      }).toList();

      // Ensure options are shuffled
      expect(initialOrder, isNot(equals([rightOption, ...wrongOptions])));
    });
  });
}
