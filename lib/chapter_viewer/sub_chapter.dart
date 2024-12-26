import 'package:flutter/material.dart';


class SectionsEnd implements Exception {}

class SubChapterViewer {
  final String title;
  final List<Widget> sections;
  SubChapterViewer({required this.title, required this.sections});
  int index = 0;

  Widget getCurrentSection(){
    return sections[index];
  }
  Widget toggleSectionForward(){

    if (index < sections.length - 1 ){
      index += 1;
      return sections[index];
    }
    throw SectionsEnd();
  }

  Widget toggleSectionBackward(){

    if (index > 0){
      index -= 1;
      return sections[index];
    }
    throw SectionsEnd();
  }

}
