import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Collaborators {
  String id;
  String name;
  String descriptionPt;
  String descriptionEn;
  List img = [];

  Collaborators({this.id, this.name, this.descriptionPt, this.descriptionEn});

  Collaborators.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.get('name');
    descriptionEn = doc.get('description_en');
    descriptionPt = doc.get('description_pt');
    img = List<String>.from(doc.data()['img'] as List<dynamic>);
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref('gs://appbiotapajos-3d160.appspot.com/collaborators/');

  Future<void> editCollaborators(Collaborators collaborators) async {

    Map<String, dynamic> data = {
      'name': collaborators.name,
      'description_en': collaborators.descriptionEn,
      'description_pt': collaborators.descriptionPt
    };

    try {
      if(collaborators.id == null){
        final doc = await FirebaseFirestore.instance.collection('collaborators').add(data);

        final List<String> uploadImage = [];

        for (final image in collaborators.img) {
          if (image as Uint8List != null) {
            final filePath = '${Uuid().v4()}.png';
            final UploadTask task = storageRef.child(filePath).putData(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImage.add(url);
          }
        }

        DocumentReference ref = FirebaseFirestore.instance.collection('collaborators').doc(doc.id);
        await ref.update({'img': uploadImage});
        collaborators.img = uploadImage;

      } else {
        DocumentReference ref =
        FirebaseFirestore.instance.collection('collaborators').doc(
            collaborators.id);

        final List<String> uploadImage = [];

        for (final image in collaborators.img) {
          if (image is Uint8List) {
            final filePath = '${DateTime.now()}.png';
            final UploadTask task = storageRef.child(filePath).putData(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImage.add(url);
          } else if (collaborators.img.contains(image)) {
            uploadImage.add(image as String);
          }
        }

        for (final image in collaborators.img) {
          if (!collaborators.img.contains(image)) {
            try {
              final ref = storage.refFromURL(image);
              await ref.delete();
            } catch (e) {
              debugPrint('Falha ao deletar $image');
            }
          }
        }

        await ref.update({'img': uploadImage, ...data});
        collaborators.img = uploadImage;
      }
    } catch (e){
      Future.error('Error ao salvar colaboradores');
    }
  }

  Future<void> delete(Collaborators collaborators) async {
    try {
      DocumentReference ref =
      FirebaseFirestore.instance.collection('collaborators').doc(collaborators.id);
      await ref.delete();
    } catch (e){
      Future.error('Error ao deletar');
    }
  }

  @override
  String toString() {
    return 'Collaborators{id: $id, name: $name, descriptionPt: $descriptionPt, descriptionEn: $descriptionEn}';
  }
}