import 'package:nlp_tutor/chapter_model/chapter_schema.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ChapterLoader {


  Future<List<Chapter>> loadChapters(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);

    return data.map((json) => Chapter.fromJson(json)).toList();
  }
}