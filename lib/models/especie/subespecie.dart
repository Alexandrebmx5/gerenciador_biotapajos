import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class SubEspecie {

  String id;
  String active;
  String activeEn;
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
  String scientificName;
  String scientificNameEn;
  var sound;
  String soundName;
  String specie;
  String specieEn;
  String subspecie;
  String subspecieEn;
  String youKnow;
  String youKnowEn;

  SubEspecie(
      {this.id,
      this.active,
      this.activeEn,
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
      this.scientificName,
      this.scientificNameEn,
      this.sound,
      this.soundName,
      this.specie,
      this.specieEn,
      this.subspecie,
      this.subspecieEn,
      this.youKnow,
      this.youKnowEn});

  SubEspecie.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    active = doc.get('active');
    activeEn = doc.get('active_en');
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
    scientificName = doc.get('scientificName');
    scientificNameEn = doc.get('scientificName_en');
    sound = doc.get('sound');
    specie = doc.get('specie');
    specieEn = doc.get('specie_en');
    subspecie = doc.get('subspecie');
    subspecieEn = doc.get('subspecie_en');
    youKnow = doc.get('youKnow');
    youKnowEn = doc.get('youKnow');
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref('gs://appbiotapajos-3d160.appspot.com');

  Future<void> save(SubEspecie subEspecie) async {
    Map<String, dynamic> data = {
      'active': subEspecie.active,
      'active_en': subEspecie.activeEn,
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
      'scientificName': subEspecie.scientificName,
      'scientificName_en': subEspecie.scientificNameEn,
      'specie': subEspecie.specie,
      'specie_en': subEspecie.specieEn,
      'subspecie': subEspecie.subspecie,
      'subspecie_en': subEspecie.subspecieEn,
      'youKnow': subEspecie.youKnow,
      'youKnow_en': subEspecie.youKnowEn,
      'img': subEspecie.img,
      'sound': subEspecie.sound,
    };

    if(subEspecie.id == null){

      final doc = await firestore.collection('species')
          .doc(subEspecie.specie.toLowerCase())
          .collection('subspecies')
          .add(data);

      // image

      final List<String> uploadImage = [];

      final filePath = '${subEspecie.nome.toLowerCase()}.png';

      for (final image in subEspecie.img) {
        if (image as Uint8List != null) {
          final UploadTask task = storageRef.child(subEspecie.specie).child(
              filePath).putData(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImage.add(url);
        }
      }

        // sound

        String downloadUrl = '';

        if(subEspecie.sound != null){
          UploadTask uploadTask = FirebaseStorage.instance.ref('sounds/${subEspecie.soundName}').
          putData(sound);
          TaskSnapshot s = await uploadTask;
          downloadUrl = await s.ref.getDownloadURL();
        }

        DocumentReference firestoreRef =
        firestore.collection('species')
            .doc(subEspecie.specie.toLowerCase())
            .collection('subspecies')
            .doc(doc.id);

        await firestoreRef.update({'img': uploadImage, 'sound': downloadUrl});
        subEspecie.img = uploadImage;

    } else {
      final List<String> uploadImage = [];

      final filePath = 'temp/${DateTime.now()}.png';

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
          .doc(subEspecie.specie.toLowerCase())
          .collection('subspecies')
          .doc(subEspecie.id);

      await firestoreRef.update({'img': uploadImage, 'sound': soundUrl});
      subEspecie.img = uploadImage;

      await firestoreRef.update(data);
    }
  }

  Future<void> delete(SubEspecie subEspecie) async {
    try {
      DocumentReference firestoreRef = firestore
          .collection('species')
          .doc(subEspecie.specie.toLowerCase())
          .collection('subspecies')
          .doc(subEspecie.id);

      await firestoreRef.delete();
    } catch (e){
      Future.error('Error ao deletar sub espécie');
    }
  }

  @override
  String toString() {
    return 'SubEspecie{id: $id, active: $active, activeEn: $activeEn, color: $color, colorEn: $colorEn, howKnow: $howKnow, howKnowEn: $howKnowEn, img: $img, locations: $locations, locationsEn: $locationsEn, nome: $nome, nomeEn: $nomeEn, reproduction: $reproduction, reproductionEn: $reproductionEn, scientificName: $scientificName, scientificNameEn: $scientificNameEn, sound: $sound, specie: $specie, specieEn: $specieEn, subspecie: $subspecie, subspecieEn: $subspecieEn, youKnow: $youKnow, youKnowEn: $youKnowEn}';
  }
}