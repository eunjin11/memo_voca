import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memovoca/model/word.dart';

class WordFirebase {
  late CollectionReference wordsReference; // collection 'words' reference
  late Stream<QuerySnapshot> wordStream; // stream of words

  var collection_name='wordlist1';
  Future initDb() async {
    wordsReference = FirebaseFirestore.instance.collection(collection_name);
    wordStream = wordsReference.snapshots();
  }

  Future initDb2(collection_name2, id) async {
    wordsReference = FirebaseFirestore.instance.collection(collection_name)
    .doc(id.id).collection(collection_name2);
    wordStream = wordsReference.snapshots();
  }


  List<Word> getWords(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Word> wordList = [];
    for (var document in snapshot.data!.docs) {
      wordList.add(Word.fromSnapshot(document));
    }
    return wordList;
  }

  List<Word> getBookmarkWords(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Word> wordList = [];
    for (var document in snapshot.data!.docs) {
      if(Word.fromSnapshot(document).isbookmark){
        wordList.add(Word.fromSnapshot(document));
      }
    }
    return wordList;
  }

  Future addWord(Word word) async {
    wordsReference.add(word.toMap());
  }

  Future updateWord(Word word) async {
    word.reference?.update(word.toMap());
  }

  Future deleteWord(Word word) async {
    word.reference?.delete();
  }

  Future<List<String>> getCollections() async {
    QuerySnapshot querySnapshot = await wordsReference.get();
    List<String> collections = [];
    querySnapshot.docs.forEach((doc) {
      collections.add(doc.id);
    });
    return collections;
  }
}