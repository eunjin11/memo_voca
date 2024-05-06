import 'package:flutter/material.dart';
import 'package:memovoca/provider/word_firestore.dart';
import 'package:memovoca/model/word.dart';
import 'package:memovoca/component/delete_word.dart';
import 'package:memovoca/component/edit_word.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class WordDetailDialog extends StatelessWidget {
  final Word word;
  final WordFirebase wordFirebase;
  WordDetailDialog({required this.word, required this.wordFirebase});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${word.title}'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${word.description}'),
        ],
      ),
      actions: [
        TextButton(
          child: Text('수정'),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditWordDialog(wordFirebase: wordFirebase, word: word,);
                });
          },
        ),
        TextButton(
          child: Text('삭제'),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DeleteWordDialog(wordFirebase: wordFirebase, word: word,);
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
