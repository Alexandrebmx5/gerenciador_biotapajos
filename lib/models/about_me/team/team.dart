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
      'description_en': team.descriptionEn,
      'description_pt': team.descriptionPt
    };

    try {
      if(team.id == null) {
        await FirebaseFirestore.instance.collection('name_team').add(data);
      } else {
        DocumentReference ref = FirebaseFirestore.instance.collection('name_team').doc(team.id);
        await ref.update(data);
      }
    } catch (e){
      Future.error('Error ao salvar time');
    }
  }

  Future<void> delete(Team team) async {
    try {
      DocumentReference ref =
      FirebaseFirestore.instance.collection('name_team').doc(team.id);
      await ref.delete();
    } catch (e){
      Future.error('Error ao deletar');
    }
  }

  @override
  String toString() {
    return 'Team{id: $id, name: $name, descriptionPt: $descriptionPt, descriptionEn: $descriptionEn}';
  }
}