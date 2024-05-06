import 'package:flutter/material.dart';
import 'package:memovoca/provider/word_firestore.dart';
import 'package:memovoca/model/word.dart';

class AddWordDialog extends StatefulWidget {
  final WordFirebase wordFirebase;

  AddWordDialog({required this.wordFirebase});

  @override
  _AddWordDialogState createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  late String title;
  late String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('단어 추가하기'),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: InputDecoration(labelText: '제목'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              decoration: InputDecoration(labelText: '설명'),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('추가'),
          onPressed: () {
            Word newWord = Word(title: title, description: description, isbookmark: false);
            widget.wordFirebase.wordsReference.add(newWord.toMap()).then((value) {
              Navigator.of(context).pop();
            });
          },
        ),
        TextButton(
          child: Text('취소'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
