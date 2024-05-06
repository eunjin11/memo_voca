import 'package:flutter/material.dart';
import 'package:memovoca/provider/word_firestore.dart';
import 'package:memovoca/screen/words_screen.dart'; // WordsScreen의 import 추가
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memovoca/model/word.dart';
import 'dart:async';
class WordListScreen extends StatefulWidget {
  @override
  _WordListScreenState createState() => _WordListScreenState();
}


class _WordListScreenState extends State<WordListScreen> {
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
        stream: wordFirebase.wordStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            wordLists = wordFirebase.getWords(snapshot);
            return Scaffold(
                body: ListView.separated(
                    itemCount: wordLists.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(wordLists[index].title),
                        trailing: IconButton(
                          icon: Icon(
                            wordLists[index].isbookmark ? Icons.star : Icons.star_border,
                            color: wordLists[index].isbookmark ? Colors.yellow : Colors.grey.withOpacity(0.5), // 북마크 상태에 따라 색상 변경
                          ),
                          onPressed: () {
                            setState(() {
                              wordLists[index].isbookmark = !wordLists[index].isbookmark; // 북마크 상태 변경
                              Word newWord = Word(
                                title: wordLists[index].title,
                                description: wordLists[index].description,
                                isbookmark: wordLists[index].isbookmark,
                                reference:
                                wordLists[index].reference,
                              );
                              wordFirebase
                                  .updateWord(newWord);
                            });}
                        ),
                        onTap: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WordsScreen(
                              title: wordLists[index].title, // 단어 목록의 제목 전달
                              id: wordLists[index].reference,
                              isbookmark: wordLists[index].isbookmark,
                            ),
                          ),
                        );
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
