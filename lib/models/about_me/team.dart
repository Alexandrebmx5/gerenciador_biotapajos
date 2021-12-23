import 'package:cloud_firestore/cloud_firestore.dart';

class Team {

  String id;
  String name;
  String descriptionPt;
  String descriptionEn;

  Team({this.id, this.name, this.descriptionPt, this.descriptionEn});

  Team.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.get('name');
    descriptionEn = doc.get('description_en');
    descriptionPt = doc.get('description_pt');
  }

  Future<void> editTeam(Team team) async {

    Map<String, dynamic> data = {
      'name': team.name,
      'description_en': descriptionEn,
      'description_pt': descriptionPt
    };

    try {
      DocumentReference ref =
      FirebaseFirestore.instance.collection('name_team').doc(team.id);
      await ref.update(data);
    } catch (e){
      Future.error('Error ao salvar time');
    }
  }

  @override
  String toString() {
    return 'Team{id: $id, name: $name, descriptionPt: $descriptionPt, descriptionEn: $descriptionEn}';
  }
}