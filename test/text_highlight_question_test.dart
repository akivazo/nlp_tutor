import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:nlp_tutor/sections_implementation/text_highlight_question.dart';

void main() {
  group('TextHighlightQuestionViewer Tests', () {
    const String question = 'Select the correct answer from the text below:';
    const String text = 'Flutter is an open-source UI software development toolkit created by Google.';
    const String answer = 'open-source UI software development toolkit';
    const String correctResponse = 'Correct! Well done.';
    const String wrongResponse = 'That is incorrect. Please try again.';

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: TextHighlightQuestionViewer(
            question: question,
            text: text,
            answer: answer,
            correctResponse: correctResponse,
            wrongResponse: wrongResponse,
          ),
        ),
      );
    }

    testWidgets('Displays the question and text', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(question), findsOneWidget); // Check question text
      expect(find.text(text), findsOneWidget); // Check full text
    });

    testWidgets('Displays message when no text is selected and submit is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('No text was selected'), findsOneWidget);
    });

    testWidgets('Displays correct response when the correct text is selected', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate selecting the correct text
      final selectableTextFinder = find.byType(SelectableText);
      final selectableText = tester.widget<SelectableText>(selectableTextFinder);
      selectableText.onSelectionChanged!(
        TextSelection(baseOffset: text.indexOf(answer), extentOffset: text.indexOf(answer) + answer.length),
        SelectionChangedCause.tap,
      );

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.textContaining(correctResponse), findsOneWidget);
    });

    testWidgets('Displays wrong response when incorrect text is selected', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate selecting incorrect text
      final incorrectSelection = 'Flutter';
      final selectableTextFinder = find.byType(SelectableText);
      final selectableText = tester.widget<SelectableText>(selectableTextFinder);
      selectableText.onSelectionChanged!(
        TextSelection(baseOffset: text.indexOf(incorrectSelection), extentOffset: text.indexOf(incorrectSelection) + incorrectSelection.length),
        SelectionChangedCause.tap,
      );

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.textContaining(wrongResponse), findsOneWidget);
    });

    testWidgets('Displays selected text in the response', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate selecting part of the text
      final selectedText = 'Flutter';
      final selectableTextFinder = find.byType(SelectableText);
      final selectableText = tester.widget<SelectableText>(selectableTextFinder);
      selectableText.onSelectionChanged!(
        TextSelection(baseOffset: text.indexOf(selectedText), extentOffset: text.indexOf(selectedText) + selectedText.length),
        SelectionChangedCause.tap,
      );

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.textContaining("The text selected is: '$selectedText'"), findsOneWidget);
    });
  });
}
