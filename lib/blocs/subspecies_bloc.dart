import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class SubspeciesBloc extends BlocBase {

  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();

  Stream<Map> get outData => _dataController.stream;

  Stream<bool> get outLoading => _loadingController.stream;

  Stream<bool> get outCreated => _createdController.stream;

  String specieId;
  DocumentSnapshot subspecies;

  Map<String, dynamic> unsavedData;

  SubspeciesBloc({this.specieId, this.subspecies}) {
    if (subspecies != null) {
      unsavedData = Map.of(subspecies.data());
      unsavedData['img'] = List.of(subspecies.data()['img']);
      unsavedData['sound'] = subspecies.data()['sound'];

      _createdController.add(true);
    } else {
      unsavedData = {
        'active': null,
        'active_en': null,
        'color': null,
        'color_en': null,
        'howKnow': null,
        'howKnow_en': null,
        'img': [],
        'lat': null,
        'long': null,
        'locations': null,
        'locations_en': null,
        'nome': null,
        'nome_en': null,
        'reproduction': null,
        'reproduction_en': null,
        'scientificName': null,
        'scientificName_en': null,
        'sound': null,
        'specie': null,
        'specie_en': null,
        'subspecie': null,
        'subspecie_en': null,
        'youKnow': null,
        'youKnow_en': null
      };

      _createdController.add(false);
    }

    _dataController.add(unsavedData);
  }

  void saveActive(String active) {
    unsavedData['active'] = active;
  }

  void saveActiveEn(String activeEn) {
    unsavedData['active_en'] = activeEn;
  }

  void saveColor(String color) {
    unsavedData['color'] = color;
  }

  void saveColorEn(String colorEn) {
    unsavedData['color_en'] = colorEn;
  }

  void saveKnowKnow(String knowKnow) {
    unsavedData['howKnow'] = knowKnow;
  }

  void saveKnowKnowEn(String knowKnowEn) {
    unsavedData['howKnow_en'] = knowKnowEn;
  }

  void saveImages(List images) {
    unsavedData["img"] = images;
  }

  void saveLat(String lat) {
    unsavedData['lat'] = lat;
  }

  void saveLong(String long) {
    unsavedData['long'] = long;
  }

  void saveLocations(String locations) {
    unsavedData['locations'] = locations;
  }

  void saveLocationsEn(String locationsEn) {
    unsavedData['locations_en'] = locationsEn;
  }

  void saveNome(String nome) {
    unsavedData['nome'] = nome;
  }

  void saveNomeEn(String nomeEn) {
    unsavedData['nome_en'] = nomeEn;
  }

  void saveReproductions(String reproductions) {
    unsavedData['reproduction'] = reproductions;
  }

  void saveReproductionsEn(String reproductionsEn) {
    unsavedData['reproduction_en'] = reproductionsEn;
  }

  void saveScientificName(String scientificName) {
    unsavedData['scientificName'] = scientificName;
  }

  void saveScientificNameEn(String scientificNameEn) {
    unsavedData['scientificName_en'] = scientificNameEn;
  }

  void saveSound(String sound) {
    unsavedData['sound'] = sound;
  }

  void saveSpecie(String specie) {
    unsavedData['specie'] = specie;
  }

  void saveSpecieEn(String specieEn) {
    unsavedData['specie_en'] = specieEn;
  }

  void saveSubspecie(String subspecie) {
    unsavedData['subspecie'] = subspecie;
  }

  void saveSubspecieEn(String subspecieEn) {
    unsavedData['subspecie_en'] = subspecieEn;
  }

  void saveYouknow(String youknow) {
    unsavedData['youKnow'] = youknow;
  }

  void saveYouknowEn(String youknowEn) {
    unsavedData['youKnow_en'] = youknowEn;
  }

  // ignore: missing_return
  Future<bool> saveSubspecies() async {
    _loadingController.add(true);
      if (subspecies != null) {
        await _uploadImages();
        await subspecies.reference.update(unsavedData);
      } else {
        DocumentReference dr = await FirebaseFirestore.instance
            .collection('species')
            .doc(specieId)
            .collection('subspecies')
            .add(Map.from(unsavedData)
          ..remove('img'));
        await _uploadImages();
        await _uploadSound();
        await dr.update(unsavedData);

        _createdController.add(true);
        _loadingController.add(false);
        _loadingController.add(false);
      }
  }

  Future _uploadImages() async {
    for(int i = 0; i < unsavedData["img"].length; i++){
      if(unsavedData["img"][i] is String) continue;

      final filePath = '${DateTime.now().millisecondsSinceEpoch.toString()}.png';

      UploadTask uploadTask = FirebaseStorage.instance.ref().child(specieId)
          .child(filePath)
          .putData(unsavedData["img"][i]);

      TaskSnapshot s = await uploadTask;
      String downloadUrl = await s.ref.getDownloadURL();

      unsavedData["img"][i] = downloadUrl;
    }
  }

  Future _uploadSound() async {

      final filePath = '${unsavedData['nome']}.mp3';

      UploadTask uploadTask = FirebaseStorage.instance.ref('sounds/$filePath').
      putData(unsavedData["sound"]);

      TaskSnapshot s = await uploadTask;
      String downloadUrl = await s.ref.getDownloadURL();

      unsavedData["sound"] = downloadUrl;

  }

  void deleteProduct(){
    subspecies.reference.delete();
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _dataController.close();
    _loadingController.close();
    _createdController.close();
  }

}