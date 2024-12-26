

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



class ChapterLoader {

  static ChapterViewer _chapterToChapterViewer(Chapter chapter){
    var explanation = SucChapterExplanation(explanation: chapter.introduction.explanation);
    var examples = SubChapterExamples(examples: chapter.introduction.examples);
    var video = SubChapterVideo(videoId: chapter.introduction.video);
    var introduction = SubChapterViewer(title: "Introduction", sections: [explanation, examples, video]);
    var subChapters = chapter.subChapters.map((subChapter) {
      var questions = subChapter.questions.map((question) => MultiPartQuestion(key: Key(question.question),
          question: question.question,
          wrongOptions: question.wrongOptions,
          rightOption: question.rightOption,
          correctResponse: question.responses.correct,
          wrongResponse: question.responses.incorrect)).toList();
      return SubChapterViewer(title: subChapter.title, sections: questions);
    }).toList();
    subChapters.insert(0, introduction);
    return ChapterViewer(subChapters: subChapters);
  }

  static Future<Map<String, ChapterViewer>> loadChapters() async {
    final String response =
        await rootBundle.loadString('assets/json/chapters.json');
    final List<dynamic> data = json.decode(response);

    return Map.fromEntries(
      data.map((json) {
        var chapter = Chapter.fromJson(json);
        return MapEntry(chapter.title, _chapterToChapterViewer(chapter));
      }),
    );
  }
}