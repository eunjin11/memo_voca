import 'package:flutter/material.dart';
import 'package:memovoca/provider/word_firestore.dart';
import 'package:memovoca/model/word.dart';

class EditWordDialog extends StatefulWidget {
  final WordFirebase wordFirebase;
  final Word word;

  EditWordDialog({required this.wordFirebase, required this.word});

  @override
  _EditWordDialogState createState() => _EditWordDialogState();
}

class _EditWordDialogState extends State<EditWordDialog> {
  late String title;
  late String description;
  //late bool isbookmark;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('단어 수정하기'),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                title = value;
              },
              decoration: InputDecoration(
                  hintText:
                  widget.word.title),
            ),
            TextField(
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(
                  hintText: widget.word
                      .description),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            child: Text('수정'),
            onPressed: () {
              Word newWord = Word(
                title: title,
                description: description,
                isbookmark: widget.word.isbookmark,
                reference:
                widget.word.reference,
              );
              widget.wordFirebase
                  .updateWord(newWord)
                  .then((value) =>
                  Navigator.of(context)
                      .pop());
            }),
        TextButton(
            child: Text('취소'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
