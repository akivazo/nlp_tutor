import 'package:flutter/material.dart';
import 'package:nlp_tutor/chapter_viewer/sub_chapter.dart';
import 'package:nlp_tutor/entrance.dart';


class ChapterViewer extends StatefulWidget {
  final List<SubChapterViewer> subChapters;
  const ChapterViewer({super.key, required this.subChapters});

  @override
  State<ChapterViewer> createState() => _ChapterViewerState();
}

class _ChapterViewerState extends State<ChapterViewer> {
  late SubChapterViewer currentSubChapter;
  late Widget currentSection;
  int subChapterIndex = 0;

  @override
  void initState(){
    super.initState();
    currentSubChapter = widget.subChapters[subChapterIndex];
    currentSection = currentSubChapter.getCurrentSection();


  }


  void toggleSectionForward(){
    try {
      currentSection = currentSubChapter.toggleSectionForward();
    } on SectionsEnd {

      if (subChapterIndex < widget.subChapters.length - 1){
        subChapterIndex += 1;
        currentSubChapter = widget.subChapters[subChapterIndex];
        currentSection = currentSubChapter.getCurrentSection();
      }

    }
  }

  void toggleSectionBackward(){
    try {
      currentSection = currentSubChapter.toggleSectionBackward();
    } on SectionsEnd {

      if (subChapterIndex > 0){
        subChapterIndex -= 1;
        currentSubChapter = widget.subChapters[subChapterIndex];
        currentSection = currentSubChapter.getCurrentSection();
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppEntrance()));
        }, icon: Icon(Icons.home)),
        centerTitle: true,
        title: Text(currentSubChapter.title,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Expanded(child: SafeArea(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: currentSection,
          ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {
                setState(() {
                  toggleSectionBackward();
                });
              }, icon: Icon(Icons.arrow_back)),
              IconButton(onPressed: () {
                setState(() {
                  toggleSectionForward();
                });
              }, icon: Icon(Icons.arrow_forward))
            ],
          )

        ],
      ),
    );
  }
}
