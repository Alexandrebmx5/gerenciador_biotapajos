import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Ucs {

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


 Ucs({this.id,
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

  Ucs.fromDocument(DocumentSnapshot doc){
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

 Reference get storageRef => storage.ref('gs://appbiotapajos-3d160.appspot.com/ucs');

 Future<void> editUcs(Ucs ucs) async {

   Map<String, dynamic> data = {
     'title': ucs.title,
     'paragraph_one': ucs.paragraphOne,
     'paragraph_two': ucs.paragraphTwo,
     'paragraph_three': ucs.paragraphThree,
     'paragraph_four': ucs.paragraphFour,
     'title_en': ucs.titleEn,
     'paragraph_one_en': ucs.paragraphOneEn,
     'paragraph_two_en': ucs.paragraphTwoEn,
     'paragraph_three_en': ucs.paragraphThreeEn,
     'paragraph_four_en': ucs.paragraphFourEn,
   };

   try {
     if(ucs.id == null) {
       final doc = await FirebaseFirestore.instance.collection('ucs').add(data);

       final List<String> uploadImage = [];

       for (final image in ucs.img) {
         if (image as Uint8List != null) {
           final filePath = '${DateTime.now()}.png';
           final UploadTask task = storageRef.child(filePath).putData(image);
           final TaskSnapshot snapshot = await task;
           final String url = await snapshot.ref.getDownloadURL();
           uploadImage.add(url);
         }
       }

       DocumentReference ref = FirebaseFirestore.instance.collection('ucs').doc(doc.id);

       await ref.update({'img': uploadImage});
       ucs.img = uploadImage;

     } else {

       final List<String> uploadImage = [];

       for (final image in ucs.img) {
         if (image is Uint8List) {
           final filePath = '${DateTime.now()}.png';
           final UploadTask task = storageRef.child(filePath).putData(image);
           final TaskSnapshot snapshot = await task;
           final String url = await snapshot.ref.getDownloadURL();
           uploadImage.add(url);
         } else if (ucs.img.contains(image)) {
           uploadImage.add(image as String);
         }
       }

       for (final image in ucs.img) {
         if (!ucs.img.contains(image)) {
           try {
             final ref = storage.refFromURL(image);
             await ref.delete();
           } catch (e) {
             debugPrint('Falha ao deletar $image');
           }
         }
       }

       DocumentReference ref = FirebaseFirestore.instance.collection('ucs').doc(ucs.id);

       await ref.update({'img': uploadImage, ...data});
       ucs.img = uploadImage;
     }
   } catch (e){
     Future.error('Error ao salvar Ucs');
   }
 }

 Future<void> delete(Ucs ucs) async {
   try {
     DocumentReference ref =
     FirebaseFirestore.instance.collection('ucs').doc(ucs.id);
     await ref.delete();
   } catch (e){
     Future.error('Error ao deletar');
   }
 }

 @override
  String toString() {
    return 'Ucs{id: $id, img: $img, title: $title, titleEn: $titleEn, paragraphOne: $paragraphOne, paragraphOneEn: $paragraphOneEn, paragraphTwo: $paragraphTwo, paragraphTwoEn: $paragraphTwoEn, paragraphThree: $paragraphThree, paragraphThreeEn: $paragraphThreeEn, paragraphFour: $paragraphFour, paragraphFourEn: $paragraphFourEn}';
 }
}