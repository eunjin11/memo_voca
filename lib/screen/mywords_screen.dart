import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memovoca/screen/flashcard_screen.dart';
import 'package:memovoca/provider/word_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memovoca/model/word.dart';
import 'package:memovoca/component/detail_word.dart';
import 'package:memovoca/component/add_word.dart';

class MyWordsScreen extends StatefulWidget {
  final String title;
  final Object? id;
  final bool isbookmark;
  const MyWordsScreen({required this.title, required this.id, required this.isbookmark});
  @override
  _MyWordsScreenState createState() => _MyWordsScreenState();
}

class _MyWordsScreenState extends State<MyWordsScreen> {
  List<Word> wordLists=[];
  WordFirebase wordFirebase = WordFirebase();

  @override
  void initState() {
    super.initState();
    setState(() {
      wordFirebase.initDb2(widget.title, widget.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: wordFirebase.wordStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          } else {

            wordLists = wordFirebase.getBookmarkWords(snapshot);

            return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title), // 전달된 제목을 AppBar의 title로 설정
                ),floatingActionButton: FloatingActionButton(
              child: Text('+', style: TextStyle(fontSize: 25)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String title = '';
                      String description = '';
                      return AddWordDialog(wordFirebase: wordFirebase);
                    });
              },
            ),
                body: ListView.separated(
                  itemCount: wordLists.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(wordLists[index].title),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FlashcardPage(wordLists: wordLists, index:index, wordFirebase: wordFirebase, id:widget.id,
                                  isbookmark :widget.isbookmark);
                              //return WordDetailDialog(word: wordLists[index], wordFirebase: wordFirebase);
                            });
                      },
                    );
                  }, separatorBuilder: (BuildContext context, int index) {  return Divider(); },
                )
            );
          }
        }
    );
  }
}
