import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AboutMeHistoric {

  String id;
  String pt;
  String en;
  String iaaPt;
  String iaaEn;
  List iaaLogo = [];


  AboutMeHistoric({this.id, this.en, this.iaaPt, this.iaaEn, this.iaaLogo});

  AboutMeHistoric.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    en = doc.get('en');
    pt = doc.get('pt');
    iaaPt = doc.get('iaa_pt');
    iaaEn = doc.get('iaa_en');
    iaaLogo = List<String>.from(doc.get('iaa_logo') as List<dynamic>);
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref('gs://appbiotapajos-3d160.appspot.com/about_me');

  Future<void> editAboutMe(AboutMeHistoric aboutMeHistoric) async {

    Map<String, dynamic> data = {
      'pt': aboutMeHistoric.pt,
      'en': aboutMeHistoric.en,
      'iaa_pt': aboutMeHistoric.iaaPt,
      'iaa_en': aboutMeHistoric.iaaEn,
    };

      DocumentReference ref =
      FirebaseFirestore.instance.collection('aboutUs').doc(aboutMeHistoric.id);

    final List<String> uploadImage = [];

    final filePath = '${DateTime.now()}.png';

    for (final image in aboutMeHistoric.iaaLogo) {
      if (image is Uint8List) {
        final UploadTask task = storageRef.child(filePath).putData(image);
        final TaskSnapshot snapshot = await task;
        final String url = await snapshot.ref.getDownloadURL();
        uploadImage.add(url);
      } else if (aboutMeHistoric.iaaLogo.contains(image)) {
        uploadImage.add(image as String);
      }
    }

    for (final image in aboutMeHistoric.iaaLogo) {
      if (!aboutMeHistoric.iaaLogo.contains(image)) {
        try {
          final ref = storage.refFromURL(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await ref.update(data);
    await ref.update({'iaa_logo': uploadImage});
    aboutMeHistoric.iaaLogo = uploadImage;
  }

  @override
  String toString() {
    return 'AboutMeHistoric{id: $id, pt: $pt, en: $en, iaaPt: $iaaPt, iaaEn: $iaaEn, iaaLogo: $iaaLogo}';
  }
}