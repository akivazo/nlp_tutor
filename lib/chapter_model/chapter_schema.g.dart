// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      subChapters: (json['subChapters'] as List<dynamic>)
          .map((e) => SubChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      introduction:
          Introduction.fromJson(json['introduction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'title': instance.title,
      'introduction': instance.introduction,
      'subChapters': instance.subChapters,
    };

SubChapter _$SubChapterFromJson(Map<String, dynamic> json) => SubChapter(
      json['title'] as String,
      (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubChapterToJson(SubChapter instance) =>
    <String, dynamic>{
      'title': instance.title,
      'questions': instance.questions,
    };

Introduction _$IntroductionFromJson(Map<String, dynamic> json) => Introduction(
      explanation: json['explanation'] as String,
      examples:
          (json['examples'] as List<dynamic>).map((e) => e as String).toList(),
      video: json['video'] as String,
    );

Map<String, dynamic> _$IntroductionToJson(Introduction instance) =>
    <String, dynamic>{
      'explanation': instance.explanation,
      'examples': instance.examples,
      'video': instance.video,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      json['type'] as String,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'type': instance.type,
    };

MultiOptionsQuestion _$MultiOptionsQuestionFromJson(
        Map<String, dynamic> json) =>
    MultiOptionsQuestion(
      json['rightOption'] as String,
      (json['wrongOptions'] as List<dynamic>).map((e) => e as String).toList(),
      question: json['question'] as String,
      responses: Responses.fromJson(json['responses'] as Map<String, dynamic>),
      type: json['type'] as String,
    );

Map<String, dynamic> _$MultiOptionsQuestionToJson(
        MultiOptionsQuestion instance) =>
    <String, dynamic>{
      'type': instance.type,
      'question': instance.question,
      'rightOption': instance.rightOption,
      'wrongOptions': instance.wrongOptions,
      'responses': instance.responses,
    };

TextHighlightQuestion _$TextHighlightQuestionFromJson(
        Map<String, dynamic> json) =>
    TextHighlightQuestion(
      text: json['text'] as String,
      question: json['question'] as String,
      rightSentence: json['rightSentence'] as String,
      responses: Responses.fromJson(json['responses'] as Map<String, dynamic>),
      type: json['type'] as String,
    );

Map<String, dynamic> _$TextHighlightQuestionToJson(
        TextHighlightQuestion instance) =>
    <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
      'question': instance.question,
      'rightSentence': instance.rightSentence,
      'responses': instance.responses,
    };

Responses _$ResponsesFromJson(Map<String, dynamic> json) => Responses(
      correct: json['correct'] as String,
      incorrect: json['incorrect'] as String,
    );

Map<String, dynamic> _$ResponsesToJson(Responses instance) => <String, dynamic>{
      'correct': instance.correct,
      'incorrect': instance.incorrect,
    };
