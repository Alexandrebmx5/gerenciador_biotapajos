import 'package:cloud_firestore/cloud_firestore.dart';

class Suggestions {

  String id;
  String name;
  String email;
  String text;
  String fileUrl;

  Suggestions({this.id, this.name, this.email, this.text});

  Suggestions.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'];
    email = document.data()['email'];
    text = document.data()['text'];
    fileUrl = document.data()['file_url'];
  }

  @override
  String toString() {
    return 'Suggestions{id: $id, name: $name, email: $email, text: $text, fileUrl: $fileUrl}';
  }
}