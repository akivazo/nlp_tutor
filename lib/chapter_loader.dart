

import 'package:flutter/cupertino.dart';
import 'package:nlp_tutor/chapter_model/chapter_schema.dart';
import 'package:nlp_tutor/chapter_viewer/chapter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nlp_tutor/chapter_viewer/sub_chapter.dart';
import 'package:nlp_tutor/sections_implementation/multi_part_question.dart';
import 'package:nlp_tutor/sections_implementation/sub_chapter_examples.dart';
import 'package:nlp_tutor/sections_implementation/sub_chapter_explanation.dart';
import 'package:nlp_tutor/sections_implementation/sub_chapter_video.dart';
import 'package:nlp_tutor/sections_implementation/text_highlight_question.dart';



class ChapterLoader {

  static ChapterViewer _chapterToChapterViewer(Chapter chapter){
    var explanation = SubChapterExplanation(explanation: chapter.introduction.explanation);
    var examples = SubChapterExamples(examples: chapter.introduction.examples);
    var video = SubChapterVideo(videoId: chapter.introduction.videoYoutubeId);
    var introduction = SubChapterViewer(title: "Introduction", sections: [explanation, examples, video]);
    var subChapters = chapter.subChapters.map((subChapter) {
      var questions = subChapter.questions.map((question) {
        if (question is MultiOptionsQuestion){
          return MultiPartQuestionViewer(key: Key(question.question),
              question: question.question,
              wrongOptions: question.wrongOptions,
              rightOption: question.rightOption,
              correctResponse: question.responses.correct,
              wrongResponse: question.responses.incorrect);
        } else if (question is TextHighlightQuestion){
          return TextHighlightQuestionViewer(key: Key(question.question),
            text: question.text,
            question: question.question,
            answer: question.rightSentence,
            correctResponse: question.responses.correct,
            wrongResponse: question.responses.incorrect,);
        }

      }).toList();
      return SubChapterViewer(title: subChapter.title, sections: questions.cast<Widget>());
    }).toList();
    subChapters.insert(0, introduction);
    return ChapterViewer(subChapters: subChapters);
  }

  Future<Map<String, ChapterViewer>> loadChapters() async {
    final String response =
        await rootBundle.loadString('assets/json/chapters.json');
    final List<dynamic> data = json.decode(response);
    try {
      return Map.fromEntries(
        data.map((json) {
          var chapter = Chapter.fromJson(json);
          return MapEntry(chapter.title, _chapterToChapterViewer(chapter));
        }),
      );
    } catch (e){
      print(e);
      rethrow;
    }

  }
}