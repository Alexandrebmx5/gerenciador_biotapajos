import 'package:cloud_firestore/cloud_firestore.dart';

class Suggestions {

  String id;
  String name;
  String email;
  String text;
  String fileUrl;
  num lat;
  num long;

  Suggestions({this.id, this.name, this.email, this.text});

  Suggestions.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'];
    email = document.data()['email'];
    if(document.data().containsKey('text')){
      text = document.data()['text'];
    }
    if(document.data().containsKey('fileUrl')){
      fileUrl = document.data()['fileUrl'];
    }
    if(document.data().containsKey('lat')){
      lat = document.data()['lat'];
      long = document.data()['long'];
    }
  }

  Future<void> delete(Suggestions suggestions) async {
    try {
      DocumentReference ref = FirebaseFirestore.instance
          .collection('suggestions')
          .doc(suggestions.id);
      ref.delete();
    } catch (e){
      Future.error('Error ao deletar sugestão');
    }
  }

  @override
  String toString() {
    return 'Suggestions{id: $id, name: $name, email: $email, text: $text, fileUrl: $fileUrl}';
  }
}