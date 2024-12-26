import 'package:json_annotation/json_annotation.dart';

part 'chapter_schema.g.dart';

@JsonSerializable()
class Chapter {
  final String title;
  final Introduction introduction;
  final List<SubChapter> subChapters;


  Chapter( {required this.subChapters, required this.title, required this.introduction});

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}

@JsonSerializable()
class SubChapter {
  final String title;
  final List<Question> questions;

  SubChapter(this.title, this.questions);

  factory SubChapter.fromJson(Map<String, dynamic> json) =>
      _$SubChapterFromJson(json);
  Map<String, dynamic> toJson() => _$SubChapterToJson(this);
}

@JsonSerializable()
class Introduction {
  final String explanation;
  final List<String> examples;
  final String video;

  Introduction(
      {required this.explanation, required this.examples, required this.video});

  factory Introduction.fromJson(Map<String, dynamic> json) =>
      _$IntroductionFromJson(json);
  Map<String, dynamic> toJson() => _$IntroductionToJson(this);
}

@JsonSerializable()
class Question {
  final String question;
  final String rightOption;
  final List<String> wrongOptions;
  final Responses responses;

  Question(this.rightOption, this.wrongOptions,
      {required this.question, required this.responses});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Responses {
  final String correct;
  final String incorrect;

  Responses({required this.correct, required this.incorrect});

  factory Responses.fromJson(Map<String, dynamic> json) =>
      _$ResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$ResponsesToJson(this);
}
