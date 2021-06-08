import 'dart:async';
import 'dart:io';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
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

  File image;
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

  void setImage(File file) {
    image = file;
    _imageController.add(file);
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

    if (image != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child("img")
          .child(pt_title)
          .putFile(image);
      TaskSnapshot snap = await task;
      dataToUpdate["img"] = await snap.ref.getDownloadURL();
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
