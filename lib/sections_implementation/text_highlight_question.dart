import 'package:flutter/material.dart';

class TextHighlightQuestionViewer extends StatefulWidget {
  final String question;
  final String text;
  final String answer;
  final String correctResponse;
  final String wrongResponse;

  const TextHighlightQuestionViewer({super.key, required this.question, required this.text, required this.answer, required this.correctResponse, required this.wrongResponse});

  @override
  State<TextHighlightQuestionViewer> createState() => _TextHighlightQuestionViewerState();
}

class _TextHighlightQuestionViewerState extends State<TextHighlightQuestionViewer> {
  TextSelection? _currentSelection;
  String response = "Select the answer from the text above then press submit";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.question, style: Theme.of(context).textTheme.headlineMedium),
          Card(
            child: SelectableText(widget.text, onSelectionChanged: (selection, cause) {
              setState(() {
                _currentSelection = selection;
              });
            },),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_currentSelection == null){
                    response = "No text was selected";
                  } else {
                    final start = _currentSelection!.start;
                    final end = _currentSelection!.end;
                    String selectedText = widget.text.substring(start, end);
                    String _response = "The text selected is: '${selectedText}'\n\n";
                    if (selectedText == widget.answer){
                      _response += "${widget.correctResponse}";
                    } else {
                      _response += "${widget.wrongResponse}";
                    }
                    response = _response;
                  }

                });


              }, child: Text("Submit")
          ),
          Text(response, style: Theme.of(context).textTheme.bodyLarge,)

        ],
      ),
    );
  }
}
