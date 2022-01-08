import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Team {

  String id;
  List img = [];
  String name;
  String descriptionPt;
  String descriptionEn;

  Team({this.id, this.name, this.descriptionPt, this.descriptionEn});

  Team.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.get('name');
    descriptionEn = doc.get('description_en');
    descriptionPt = doc.get('description_pt');
    img = List<String>.from(doc.data()['img'] as List<dynamic>);
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref('gs://appbiotapajos-3d160.appspot.com/team/');

  Future<void> editTeam(Team team) async {

    Map<String, dynamic> data = {
      'name': team.name,
      'description_en': team.descriptionEn,
      'description_pt': team.descriptionPt
    };

    try {
      if(team.id == null) {
        final doc = await FirebaseFirestore.instance.collection('name_team').add(data);

        final List<String> uploadImage = [];

        for (final image in team.img) {
          if (image as Uint8List != null) {
            final filePath = '${Uuid().v4()}.png';
            final UploadTask task = storageRef.child(filePath).putData(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImage.add(url);
          }
        }

        DocumentReference ref = FirebaseFirestore.instance.collection('name_team').doc(doc.id);
        await ref.update({'img': uploadImage});
        team.img = uploadImage;

      } else {
        DocumentReference ref = FirebaseFirestore.instance.collection('name_team').doc(team.id);

        final List<String> uploadImage = [];

        for (final image in team.img) {
          if (image is Uint8List) {
            final filePath = '${DateTime.now()}.png';
            final UploadTask task = storageRef.child(filePath).putData(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImage.add(url);
          } else if (team.img.contains(image)) {
            uploadImage.add(image as String);
          }
        }

        for (final image in team.img) {
          if (!team.img.contains(image)) {
            try {
              final ref = storage.refFromURL(image);
              await ref.delete();
            } catch (e) {
              debugPrint('Falha ao deletar $image');
            }
          }
        }

        await ref.update({'img': uploadImage, ...data});
        team.img = uploadImage;
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