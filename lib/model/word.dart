import 'package:cloud_firestore/cloud_firestore.dart';

class Word {
  late int? id;
  late bool isbookmark;
  late String title;
  late String description;
  late DocumentReference? reference;

  Word({
    this.id,
    required this.isbookmark,
    required this.title,
    required this.description,
    this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isbookmark': isbookmark,
      'title': title,
      'description': description,
    };
  }

  Word.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    isbookmark = map?['isbookmark'];
    title = map?['title'];
    description = map?['description'];
  }

  Word.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    id = map['id'];
    isbookmark = map['isbookmark'];
    title = map['title'];
    description = map['description'];
    reference = document.reference;
  }
}