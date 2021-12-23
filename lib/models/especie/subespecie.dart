import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class SubEspecie {

  String id;
  String specieSimilar;
  String specieSimilarEn;
  String color;
  String colorEn;
  String howKnow;
  String howKnowEn;
  List img = [];
  String locations;
  String locationsEn;
  String nome;
  String nomeEn;
  String reproduction;
  String reproductionEn;
  String family;
  String familyEn;
  var sound;
  String soundName;
  String group;
  String groupEn;
  String specie;
  String specieEn;
  String youKnow;
  String youKnowEn;
  String activityEn;
  String activity;
  String whereLive;
  String whereLiveEn;

  SubEspecie(
      {this.id,
      this.specieSimilar,
      this.specieSimilarEn,
      this.color,
      this.colorEn,
      this.howKnow,
      this.howKnowEn,
      this.img,
      this.locations,
      this.locationsEn,
      this.nome,
      this.nomeEn,
      this.reproduction,
      this.reproductionEn,
      this.family,
      this.familyEn,
      this.sound,
      this.soundName,
      this.group,
      this.groupEn,
      this.specie,
      this.specieEn,
      this.youKnow,
      this.youKnowEn,
      this.activity,
      this.activityEn,
      this.whereLive,
      this.whereLiveEn});

  SubEspecie.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    specieSimilar = doc.get('specie_similar');
    specieSimilarEn = doc.get('specie_similar_en');
    color = doc.get('color');
    colorEn = doc.get('color_en');
    howKnow = doc.get('howKnow');
    howKnowEn = doc.get('howKnow_en');
    img = List<String>.from(doc.get('img') as List<dynamic>);
    locations = doc.get('locations');
    locationsEn = doc.get('locations_en');
    nome = doc.get('nome');
    nomeEn = doc.get('nome_en');
    reproduction = doc.get('reproduction');
    reproductionEn = doc.get('reproduction_en');
    family = doc.get('family');
    familyEn = doc.get('family_en');
    sound = doc.get('sound');
    group = doc.get('group');
    groupEn = doc.get('group_en');
    specie = doc.get('specie');
    specieEn = doc.get('specie_en');
    youKnow = doc.get('youKnow');
    youKnowEn = doc.get('youKnow');
    activity = doc.get('activity');
    activityEn = doc.get('activity_en');
    whereLive = doc.get('where_live');
    whereLiveEn = doc.get('where_live_en');
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref('gs://appbiotapajos-3d160.appspot.com/species');

  Future<void> save(SubEspecie subEspecie) async {
    Map<String, dynamic> data = {
      'specie_similar': subEspecie.specieSimilar,
      'specie_similar_en': subEspecie.specieSimilarEn,
      'color': subEspecie.color,
      'color_en': subEspecie.colorEn,
      'howKnow': subEspecie.howKnow,
      'howKnow_en': subEspecie.howKnowEn,
      'locations': subEspecie.locations,
      'locations_en': subEspecie.locationsEn,
      'nome': subEspecie.nome,
      'nome_en': subEspecie.nomeEn,
      'reproduction': subEspecie.reproduction,
      'reproduction_en': subEspecie.reproductionEn,
      'family': subEspecie.family,
      'family_en': subEspecie.familyEn,
      'specie': subEspecie.specie,
      'specie_en': subEspecie.specieEn,
      'group': subEspecie.group,
      'group_en': subEspecie.groupEn,
      'youKnow': subEspecie.youKnow,
      'youKnow_en': subEspecie.youKnowEn,
      'activity': subEspecie.activity,
      'activity_en': subEspecie.activityEn,
      'where_live': subEspecie.whereLive,
      'where_live_en': subEspecie.whereLiveEn,
      if(subEspecie.img.isEmpty) 'img': [],
    };

    if(subEspecie.id == null){

      final doc = await firestore.collection('species')
          .doc(subEspecie.group.toLowerCase())
          .collection('subspecies')
          .add(data);

      // image

      final List<String> uploadImage = [];

      final filePath = '${subEspecie.group.toLowerCase()}.png';

      for (final image in subEspecie.img) {
        if (image as Uint8List != null) {
          final UploadTask task = storageRef.child(filePath).putData(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImage.add(url);
        }
      }

        // sound
        String downloadUrl = '';

        if(subEspecie.sound != null){
          UploadTask uploadTask = storageRef.child('sounds/${subEspecie.soundName}').
          putData(sound);
          TaskSnapshot s = await uploadTask;
          downloadUrl = await s.ref.getDownloadURL();
        }

        DocumentReference firestoreRef =
        firestore.collection('species')
            .doc(subEspecie.group.toLowerCase())
            .collection('subspecies')
            .doc(doc.id);

        await firestoreRef.update({'img': uploadImage, 'sound': downloadUrl});
        subEspecie.img = uploadImage;

    } else {
      final List<String> uploadImage = [];

      final filePath = '${subEspecie.group.toLowerCase()}.png';

      for (final image in subEspecie.img) {
        if (image is Uint8List) {
          final UploadTask task = storageRef.child(filePath).putData(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImage.add(url);
        } else if (subEspecie.img.contains(image)) {
          uploadImage.add(image as String);
        }
      }

      for (final image in subEspecie.img) {
        if (!subEspecie.img.contains(image)) {
          try {
            final ref = storage.refFromURL(image);
            await ref.delete();
          } catch (e) {
            debugPrint('Falha ao deletar $image');
          }
        }
      }

      String soundUrl = '';

      // sound
      if(subEspecie.sound != String) {
        UploadTask uploadTask = FirebaseStorage.instance.ref('sounds/${subEspecie.soundName}').
        putData(sound);
        TaskSnapshot s = await uploadTask;
        String downloadUrl = await s.ref.getDownloadURL();
        soundUrl = downloadUrl;
      } else if(subEspecie.sound.contains(subEspecie.sound)) {
        soundUrl = subEspecie.sound.toString();
      }

      if (!subEspecie.sound.contains(subEspecie.sound)) {
        try {
          final ref = storage.refFromURL(subEspecie.sound);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar ${subEspecie.sound}');
        }
      }

      DocumentReference firestoreRef =
      firestore.collection('species')
          .doc(subEspecie.group.toLowerCase())
          .collection('subspecies')
          .doc(subEspecie.id);

      await firestoreRef.update({'img': uploadImage, 'sound': soundUrl});
      subEspecie.img = uploadImage;

      await firestoreRef.update(data);
    }
  }

  Future<void> delete(SubEspecie subEspecie) async {
    try {
      DocumentReference ref = firestore
          .collection('species')
          .doc(subEspecie.group.toLowerCase())
          .collection('subspecies')
          .doc(subEspecie.id);

      await ref.delete();
    } catch (e){
      Future.error('Error ao deletar sub espécie');
    }
  }

  @override
  String toString() {
    return 'SubEspecie{id: $id, specieSimilar: $specieSimilar, specieSimilarEn: $specieSimilarEn, color: $color, colorEn: $colorEn, howKnow: $howKnow, howKnowEn: $howKnowEn, img: $img, locations: $locations, locationsEn: $locationsEn, nome: $nome, nomeEn: $nomeEn, reproduction: $reproduction, reproductionEn: $reproductionEn, family: $family, familyEn: $familyEn, sound: $sound, soundName: $soundName, group: $group, groupEn: $groupEn, specie: $specie, specieEn: $specieEn, youKnow: $youKnow, youKnowEn: $youKnowEn, activityEn: $activityEn, activity: $activity, whereLive: $whereLive, whereLiveEn: $whereLiveEn}';
  }
}