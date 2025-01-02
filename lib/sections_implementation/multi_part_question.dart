import 'package:flutter/material.dart';
import 'package:nlp_tutor/sections_implementation/question_viewer.dart';

class MultiPartQuestionViewer extends QuestionViewer {
  final String question;
  final List<String> wrongOptions;
  final String rightOption;
  final String correctResponse;
  final String wrongResponse;

  const MultiPartQuestionViewer({super.key, required this.question, required this.wrongOptions, required this.rightOption, required this.correctResponse, required this.wrongResponse});

  @override
  State<MultiPartQuestionViewer> createState() => _MultiPartQuestionViewerState();
}

class _MultiPartQuestionViewerState extends State<MultiPartQuestionViewer> {
  String response = "";
  late List<String> options;

  @override
  void initState() {
    super.initState();
    options = List<String>.from(widget.wrongOptions);
    options.add(widget.rightOption);
    options.shuffle();
  }

  void _pickOption(String option){
    setState(() {
      if (option == widget.rightOption){
        response = widget.correctResponse;
      } else {
        response = widget.wrongResponse;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.question, style: Theme.of(context).textTheme.headlineMedium,),
        Wrap(
          children: options.map((option) => Card(child: TextButton(onPressed: () => _pickOption(option), child: Text(option)),)).toList()
        ),
        SizedBox(
          height: 200,
          child: Text(response),
        )

      ],
    );


  }
}
