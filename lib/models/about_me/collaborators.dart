import 'package:cloud_firestore/cloud_firestore.dart';

class Collaborators {
  String id;
  String name;
  String descriptionPt;
  String descriptionEn;

  Collaborators({this.id, this.name, this.descriptionPt, this.descriptionEn});

  Collaborators.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.get('name');
    descriptionEn = doc.get('description_en');
    descriptionPt = doc.get('description_pt');
  }

  Future<void> editCollaborators(Collaborators collaborators) async {

    Map<String, dynamic> data = {
      'name': collaborators.name,
      'description_en': collaborators.descriptionEn,
      'description_pt': collaborators.descriptionPt
    };

    try {
      DocumentReference ref =
      FirebaseFirestore.instance.collection('collaborators').doc(collaborators.id);
      await ref.update(data);
    } catch (e){
      Future.error('Error ao salvar colaboradores');
    }
  }

  @override
  String toString() {
    return 'Collaborators{id: $id, name: $name, descriptionPt: $descriptionPt, descriptionEn: $descriptionEn}';
  }
}