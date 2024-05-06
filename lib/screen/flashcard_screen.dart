import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memovoca/screen/wordlist_screen.dart';
import 'package:memovoca/provider/word_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memovoca/model/word.dart';
import 'package:memovoca/component/detail_word.dart';
import 'package:memovoca/component/add_word.dart';
import 'package:memovoca/component/delete_word.dart';
import 'package:memovoca/component/edit_word.dart';


class FlashcardPage extends StatefulWidget {
  late final List<Word> wordLists;
  final Object? id;
  final WordFirebase wordFirebase;
  bool isbookmark;
  int index;

  FlashcardPage({required this.wordLists, required this.index, required this.wordFirebase, required this.id
  ,required this.isbookmark});
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  bool showDefinition = false;

  void toggleDefinition() {
    setState(() {
      showDefinition = !showDefinition;
    });
  }

  void goToPreviousWord() {
    if (widget.index > 0) {
      setState(() {
        widget.index--; // 현재 인덱스에서 1을 뺍니다.
        showDefinition = false; // 인덱스를 변경하면서 정답을 감춥니다.
      });
    }
  }

  void goToNextWord() {
    if (widget.index < widget.wordLists.length - 1) {
      setState(() {
        widget.index++; // 현재 인덱스에서 1을 더합니다.
        showDefinition = false; // 인덱스를 변경하면서 정답을 감춥니다.
      });
    }
  }

  void doBookmark() {
    
    if (widget.wordLists[widget.index].isbookmark) {
      setState(() {
        widget.wordLists[widget.index].isbookmark=false; // 북마크 해제
        Word newWord = Word(
          title: widget.wordLists[widget.index].title,
          description: widget.wordLists[widget.index].description,
          isbookmark: widget.wordLists[widget.index].isbookmark,
          reference:
          widget.wordLists[widget.index].reference,
        );
        widget.wordFirebase
            .updateWord(newWord);
      });
    }else{
      setState(() {
        widget.wordLists[widget.index].isbookmark = true;
        Word newWord = Word(
          title: widget.wordLists[widget.index].title,
          description: widget.wordLists[widget.index].description,
          isbookmark: widget.wordLists[widget.index].isbookmark,
          reference:
          widget.wordLists[widget.index].reference,
        );
        widget.wordFirebase
            .updateWord(newWord);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('단어 퀴즈'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(), // 여백 생성
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    //Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditWordDialog(wordFirebase: widget.wordFirebase, word: widget.wordLists[widget.index],);
                        }).then((value) {
                      // 수정이 완료된 후에 다시 빌드하여 카드의 내용을 업데이트합니다.
                          setState(() {
                            Navigator.of(context).pop();
                          });

                    });

                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    //Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DeleteWordDialog(wordFirebase: widget.wordFirebase, word: widget.wordLists[widget.index]);
                        }).then((value) {
                      // 수정이 완료된 후에 다시 빌드하여 카드의 내용을 업데이트합니다.
                      setState(() {
                        if (widget.index < widget.wordLists.length - 1) {
                          // 현재 인덱스가 리스트의 마지막이 아니면 다음 단어로 이동합니다.
                          goToNextWord();
                        } else if(widget.index > 0){
                          // 현재 인덱스가 리스트의 마지막이면 이전 화면으로 돌아갑니다.
                          goToPreviousWord();
                        }else{
                          Navigator.of(context).pop();
                        }

                      });

                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 200,
              child: Center(
                child: Text(
                  widget.wordLists[widget.index].title,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 250,
              width: 400,
              child: GestureDetector(
                onTap: toggleDefinition,
                child: Card(
                  elevation: 4,
                  child: Center(
                    child: Text(
                      showDefinition ? widget.wordLists[widget.index].description : "정답을 맞춰보세요",
                      style: TextStyle(fontSize: showDefinition ? 24:20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: widget.index > 0 ? goToPreviousWord : null,
                  color: widget.index > 0 ? null : Colors.grey.withOpacity(0.5),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: widget.index < widget.wordLists.length - 1 ? goToNextWord : null,
                  color: widget.index < widget.wordLists.length - 1 ? null : Colors.grey.withOpacity(0.5),

                ),
                IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: doBookmark,
                  color: widget.wordLists[widget.index].isbookmark ? Colors.yellow : Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
