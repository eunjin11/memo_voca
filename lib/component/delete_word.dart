import 'package:flutter/material.dart';
import 'package:memovoca/provider/word_firestore.dart';
import 'package:memovoca/model/word.dart';

class DeleteWordDialog extends StatefulWidget {
  final WordFirebase wordFirebase;
  final Word word;

  DeleteWordDialog({required this.wordFirebase, required this.word});

  @override
  _DeleteWordDialogState createState() => _DeleteWordDialogState();
}

class _DeleteWordDialogState extends State<DeleteWordDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text('할 일 삭제하기'),
          content: Container(
            child: Text('삭제하시겠습니까?'),
          ),
          actions: [
            TextButton(
                child: Text('삭제'),
                onPressed: () {
                  widget.wordFirebase
                      .deleteWord(widget.word)
                      .then((value) {
                    Navigator.of(context).pop();
                  });
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
