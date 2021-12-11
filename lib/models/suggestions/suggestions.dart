import 'package:cloud_firestore/cloud_firestore.dart';

class Suggestions {

  String id;
  String name;
  String email;
  String comment;
  String fileUrl;
  String lat;
  String long;
  String date;
  String time;
  String environment;
  String behavior;
  bool approved;
  String location;
  String nameSpecie;
  String sightedPlace;
  Timestamp created;

  Suggestions(
      {this.id,
      this.name,
      this.email,
      this.comment,
      this.fileUrl,
      this.lat,
      this.long,
      this.date,
      this.time,
      this.environment,
      this.behavior,
      this.approved,
      this.location,
      this.nameSpecie,
      this.sightedPlace,
      this.created});

  Suggestions.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.data().containsKey('name_user') ? doc.get('name_user') : null;
    email = doc.data().containsKey('email_user') ? doc.get('email_user') : null;
    comment = doc.data().containsKey('comment') ? doc.get('comment') : null;
    fileUrl = doc.data().containsKey('file_url') ? doc.get('file_url') : null;
    lat = doc.data().containsKey('lat') ? doc.get('lat') : null;
    time = doc.data().containsKey('long') ? doc.get('long') : null;
    date = doc.data().containsKey('date') ? doc.get('date') : null;
    time = doc.data().containsKey('time') ? doc.get('time') : null;
    environment = doc.data().containsKey('environment') ? doc.get('environment') : null;
    behavior = doc.data().containsKey('behavior') ? doc.get('behavior') : null;
    approved = doc.data().containsKey('approved') ? doc.get('approved') : false;
    location = doc.data().containsKey('location') ? doc.get('location') : null;
    nameSpecie = doc.data().containsKey('name_specie') ? doc.get('name_specie') : null;
    sightedPlace = doc.data().containsKey('sighted_place') ? doc.get('sighted_place') : null;
    created = doc.get('created');
  }

  Future<void> delete(Suggestions suggestions) async {
    try {
      DocumentReference ref = FirebaseFirestore.instance
          .collection('suggestions')
          .doc(suggestions.id);
      await ref.delete();
    } catch (e){
      Future.error('Error ao deletar sugestão');
    }
  }

  Future<void> approvedSuggestions(Suggestions suggestions) async {
    try {
      DocumentReference ref = FirebaseFirestore.instance
          .collection('suggestions')
          .doc(suggestions.id);
      await ref.update({'approved': true});
    } catch (e){
      Future.error('Error ao aprovar sugestão');
    }
  }

  @override
  String toString() {
    return 'Suggestions{id: $id, name: $name, email: $email, comment: $comment, fileUrl: $fileUrl, lat: $lat, long: $long, date: $date, time: $time, environment: $environment, behavior: $behavior, approved: $approved, location: $location, nameSpecie: $nameSpecie, sightedPlace: $sightedPlace, created: $created}';
  }
}