import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Presently {

  String id;
  List img = [];
  String title;
  String titleEn;
  String paragraphOne;
  String paragraphOneEn;
  String paragraphTwo;
  String paragraphTwoEn;
  String paragraphThree;
  String paragraphThreeEn;
  String paragraphFour;
  String paragraphFourEn;


  Presently({this.id,
    this.img,
    this.title,
    this.titleEn,
    this.paragraphOne,
    this.paragraphOneEn,
    this.paragraphTwo,
    this.paragraphTwoEn,
    this.paragraphThree,
    this.paragraphThreeEn,
    this.paragraphFour,
    this.paragraphFourEn});

  Presently.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    title = doc.get('title');
    paragraphOne = doc.get('paragraph_one');
    paragraphTwo = doc.get('paragraph_two');
    paragraphThree = doc.get('paragraph_three');
    paragraphFour = doc.get('paragraph_four');
    titleEn = doc.get('title_en');
    paragraphOneEn = doc.get('paragraph_one_en');
    paragraphTwoEn = doc.get('paragraph_two_en');
    paragraphThreeEn = doc.get('paragraph_three_en');
    paragraphFourEn = doc.get('paragraph_four_en');
    img = List<String>.from(doc.get('img') as List<dynamic>);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef => storage.ref('gs://appbiotapajos-3d160.appspot.com/presently');

  Future<void> editPresently(Presently presently) async {

    Map<String, dynamic> data = {
      'title': presently.title,
      'paragraph_one': presently.paragraphOne,
      'paragraph_two': presently.paragraphTwo,
      'paragraph_three': presently.paragraphThree,
      'paragraph_four': presently.paragraphFour,
      'title_en': presently.titleEn,
      'paragraph_one_en': presently.paragraphOneEn,
      'paragraph_two_en': presently.paragraphTwoEn,
      'paragraph_three_en': presently.paragraphThreeEn,
      'paragraph_four_en': presently.paragraphFourEn,
    };

    try {
      if(presently.id == null) {
        final doc = await FirebaseFirestore.instance.collection('presently').add(data);

        final List<String> uploadImage = [];

        for (final image in presently.img) {
          if (image as Uint8List != null) {
            final filePath = '${DateTime.now()}.png';
            final UploadTask task = storageRef.child(filePath).putData(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImage.add(url);
          }
        }

        DocumentReference ref = FirebaseFirestore.instance.collection('presently').doc(doc.id);

        await ref.update({'img': uploadImage});
        presently.img = uploadImage;

      } else {

        final List<String> uploadImage = [];

        for (final image in presently.img) {
          if (image is Uint8List) {
            final filePath = '${DateTime.now()}.png';
            final UploadTask task = storageRef.child(filePath).putData(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImage.add(url);
          } else if (presently.img.contains(image)) {
            uploadImage.add(image as String);
          }
        }

        for (final image in presently.img) {
          if (!presently.img.contains(image)) {
            try {
              final ref = storage.refFromURL(image);
              await ref.delete();
            } catch (e) {
              debugPrint('Falha ao deletar $image');
            }
          }
        }

        DocumentReference ref = FirebaseFirestore.instance.collection('presently').doc(presently.id);

        await ref.update({'img': uploadImage, ...data});
        presently.img = uploadImage;
      }
    } catch (e){
      Future.error('Error ao salvar presently');
    }
  }

  Future<void> delete(Presently presently) async {
    try {
      DocumentReference ref =
      FirebaseFirestore.instance.collection('presently').doc(presently.id);
      await ref.delete();
    } catch (e){
      Future.error('Error ao deletar');
    }
  }

  @override
  String toString() {
    return 'Presently{id: $id, img: $img, title: $title, titleEn: $titleEn, paragraphOne: $paragraphOne, paragraphOneEn: $paragraphOneEn, paragraphTwo: $paragraphTwo, paragraphTwoEn: $paragraphTwoEn, paragraphThree: $paragraphThree, paragraphThreeEn: $paragraphThreeEn, paragraphFour: $paragraphFour, paragraphFourEn: $paragraphFourEn}';
  }
}