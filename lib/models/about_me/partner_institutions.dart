import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PartnerInstitutions {
  String id;
  List img = [];

  PartnerInstitutions({this.id, this.img});

  PartnerInstitutions.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    img = List<String>.from(doc.data()['logo'] as List<dynamic>);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef => storage.ref('gs://appbiotapajos-3d160.appspot.com/about_me');

  Future<void> editPartnerInstitutions(PartnerInstitutions partnerInstitutions) async {
    try {
      final List<String> uploadImage = [];

      for (final image in partnerInstitutions.img) {
        if (image is Uint8List) {
          final filePath = '${DateTime.now()}.png';
          final UploadTask task = storageRef.child(filePath).putData(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImage.add(url);
        } else if (partnerInstitutions.img.contains(image)) {
          uploadImage.add(image as String);
        }
      }

      for (final image in partnerInstitutions.img) {
        if (!partnerInstitutions.img.contains(image)) {
          try {
            final ref = storage.refFromURL(image);
            await ref.delete();
          } catch (e) {
            debugPrint('Falha ao deletar $image');
          }
        }
      }

      DocumentReference firestoreRef =
      firestore.collection('partner_institutions').doc('gB4TTNA4N1JUkfuAJPf8');

      await firestoreRef.update({
        'logo': uploadImage,
      });
      partnerInstitutions.img = uploadImage;
    } catch (e){
      Future.error('Error ao salvar Partner Institutions');
    }
  }

  @override
  String toString() {
    return 'PartnerInstitutions{id: $id, logo: $img}';
  }
}