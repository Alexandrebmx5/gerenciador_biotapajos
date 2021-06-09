import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {

  final FirebaseStorage storage = FirebaseStorage.instance;


  // ignore: non_constant_identifier_names, close_sinks
  final _pt_titleController = BehaviorSubject<String>();
  // ignore: non_constant_identifier_names, close_sinks
  final _en_titleController = BehaviorSubject<String>();
  final _imageController = BehaviorSubject();
  final _deleteController = BehaviorSubject<bool>();

  Stream<String> get outTitle => _pt_titleController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (title, sink) {
        if (title.isEmpty)
          sink.addError("Insira um título");
        else
          sink.add(title);
      }));
  Stream<String> get outTitleEn => _en_titleController.stream.transform(
      StreamTransformer<String, String>.fromHandlers(
          handleData: (title, sink) {
            if (title.isEmpty)
              sink.addError("Insira um título em inglês");
            else
              sink.add(title);
          }));
  Stream get outImage => _imageController.stream;
  Stream<bool> get outDelete => _deleteController.stream;

  Stream<bool> get submitValid =>
      Rx.combineLatest2(outTitle, outImage, (a, b) => true);

  DocumentSnapshot category;

  Uint8List image;
  // ignore: non_constant_identifier_names
  String pt_title;
  // ignore: non_constant_identifier_names
  String en_title;

  CategoryBloc(this.category) {
    if (category != null) {
      pt_title = category.data()['pt'];
      en_title = category.data()['en'];
      _pt_titleController.add(category.data()['pt']);
      _en_titleController.add(category.data()['en']);
      _imageController.add(category.data()['img']);
      _deleteController.add(true);
    } else {
      _deleteController.add(false);
    }
  }

  void setImage(Uint8List fileBytes) {
    image = fileBytes;
    _imageController.add(fileBytes);
  }

  void setTitle(String title) {
    this.pt_title = title;
    _pt_titleController.add(title);
  }

  void setTitleEn(String title) {
    this.en_title = title;
    _en_titleController.add(title);
  }

  void delete() {
    category.reference.delete();
  }

  Future saveData() async {
    if (image == null && category != null && pt_title == category.data()["pt"] && en_title == category.data()['en'])
      return;

    Map<String, dynamic> dataToUpdate = {};

    final filePath = 'temp/${DateTime.now()}.png';//path to save Storage

      if (image != null) {
        final UploadTask task = storage.refFromURL('gs://appbiotapajos-3d160.appspot.com/list_thumb')
            .child(filePath)
            .putData(image);
        final TaskSnapshot snapshot = await task;
        final String url = await snapshot.ref.getDownloadURL();
        dataToUpdate['img'] = url;
      }

    if (category == null || pt_title != category.data()["pt"]) {
      dataToUpdate["pt"] = pt_title;
      dataToUpdate['en'] = en_title;
    }

    if (category == null) {
      await FirebaseFirestore.instance
          .collection("species")
          .doc(pt_title.toLowerCase())
          .set(dataToUpdate);
    } else {
      await category.reference.update(dataToUpdate);
    }
  }

  @override
  void dispose() {
    _pt_titleController.close();
    _en_titleController.close();
    _imageController.close();
    _deleteController.close();
  }
}
