
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
  final String videoYoutubeId; // the video id from the youtube url. e.g. for this url: https://www.youtube.com/watch?v=sw_O7C1OzD0&t=1s the video id is the part after the 'v=': 'sw_O7C1OzD0&t=1s'

  Introduction(
      {required this.explanation, required this.examples, required this.videoYoutubeId});

  factory Introduction.fromJson(Map<String, dynamic> json) =>
      _$IntroductionFromJson(json);
  Map<String, dynamic> toJson() => _$IntroductionToJson(this);
}

@JsonSerializable()
class Question{
  final String type;

  Question(this.type);
  
  factory Question.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'MultiOptionsQuestion':
        return MultiOptionsQuestion.fromJson(json);
      case 'TextHighlightQuestion':
        return TextHighlightQuestion.fromJson(json);
      default:
        throw Exception('Unknown type: ${json['type']}');
    }
  }
}

@JsonSerializable()
class MultiOptionsQuestion extends Question {
  final String question;
  final String rightOption;
  final List<String> wrongOptions;
  final Responses responses;

  MultiOptionsQuestion(this.rightOption, this.wrongOptions,
      {required this.question, required this.responses, required String type}) : super(type);

  factory MultiOptionsQuestion.fromJson(Map<String, dynamic> json) =>
      _$MultiOptionsQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$MultiOptionsQuestionToJson(this);
}


@JsonSerializable()
class TextHighlightQuestion extends Question {
  final String text;
  final String question;
  final String rightSentence;
  final Responses responses;



  factory TextHighlightQuestion.fromJson(Map<String, dynamic> json) =>
      _$TextHighlightQuestionFromJson(json);

  TextHighlightQuestion({required this.text, required this.question, required this.rightSentence, required this.responses, required String type}): super(type);
  Map<String, dynamic> toJson() => _$TextHighlightQuestionToJson(this);
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
