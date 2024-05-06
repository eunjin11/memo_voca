import 'package:flutter/material.dart';
import 'package:memovoca/provider/word_firestore.dart';
import 'package:memovoca/screen/mywords_screen.dart'; // WordsScreen의 import 추가
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memovoca/model/word.dart';

class MyWordListScreen extends StatefulWidget {
  const MyWordListScreen({super.key});

  @override
  State<MyWordListScreen> createState() => _MyWordListState();
}

class _MyWordListState extends State<MyWordListScreen> {
  List<Word> wordLists=[];
  WordFirebase wordFirebase = WordFirebase();

  @override
  void initState() {
    super.initState();
    setState(() {
      wordFirebase.initDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          wordLists = wordFirebase.getBookmarkWords(snapshot);
          return Scaffold(
            body: ListView.separated(
              itemCount: wordLists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(wordLists[index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWordsScreen(
                          title: wordLists[index].title,
                          id: wordLists[index].reference,
                          isbookmark: wordLists[index].isbookmark,
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          );
        }
      },
      stream: wordFirebase.wordStream,
    );
  }
}