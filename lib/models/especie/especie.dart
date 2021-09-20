import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Especie {

  String id;
  String pt;
  String en;
  List img = [];

  Especie({this.id, this.pt, this.en, this.img});

  Especie.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    pt = doc.get('pt');
    en = doc.get('en');
    img = List<String>.from(doc.get('img') as List<dynamic>);
  }
  
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref('gs://appbiotapajos-3d160.appspot.com/species');
  
  Future<void> save(Especie especie) async {
    Map<String, dynamic> data = {
      'pt': especie.pt,
      'en': especie.en,
    };
    
    if(especie.id == null){
      firestore.collection('species').doc(especie.pt.toLowerCase()).set(data);

      final List<String> uploadImage = [];

      final filePath = '${especie.pt.toLowerCase()}.png';

      for (final image in especie.img) {
        if (image as Uint8List != null) {
          final UploadTask task = storageRef.child(filePath).putData(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImage.add(url);
        }

        DocumentReference firestoreRef =
        firestore.collection('species').doc(especie.pt.toLowerCase());

        print(uploadImage);

        await firestoreRef.update({
          'img': uploadImage,
        });
        especie.img = uploadImage;
      }
    } else {

      final List<String> uploadImage = [];

      final filePath = 'temp/${DateTime.now()}.png';

      for (final image in especie.img) {
        if (image is Uint8List) {
          final UploadTask task = storageRef.child(filePath).putData(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImage.add(url);
        } else if (especie.img.contains(image)) {
          uploadImage.add(image as String);
        }
      }

      for (final image in especie.img) {
        if (!especie.img.contains(image)) {
          try {
            final ref = storage.refFromURL(image);
            await ref.delete();
          } catch (e) {
            debugPrint('Falha ao deletar $image');
          }
        }
      }

      DocumentReference ref = firestore.collection('species').doc(especie.id);

      await ref.update({'img': uploadImage});
      especie.img = uploadImage;

      await ref.update(data);
    }
  }
  
  Future<void> delete(Especie especie) async {
    try {
      DocumentReference ref = firestore.collection('species').doc(especie.id);
      await ref.delete();
    } catch (e){
      return Future.error('Error ao deletar Especie');
    }
  }
  
  @override
  String toString() {
    return 'Especie{id: $id, pt: $pt, en: $en, img: $img}';
  }
}